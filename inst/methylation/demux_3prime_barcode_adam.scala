import org.apache.spark.sql.functions._
import org.apache.spark.SparkContext
import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.adam.rdd.read.AlignmentRecordRDD
import org.bdgenomics.adam.sql.AlignmentRecord
import org.bdgenomics.adam.rdd.read.{ AlignmentRecordRDD, AnySAMOutFormatter }
import java.io.File
import sys.process._
import org.apache.spark.sql.SaveMode
import org.apache.spark.sql.expressions.Window


def getListOfFiles(dir: File, extensions: List[String]): List[File] = {
    dir.listFiles.filter(_.isFile).toList.filter { file =>
        extensions.exists(file.getName.endsWith(_))
    }
}

val barcodes = (spark.read.format("csv")
        .option("header", "true")
        .load("./barcodes.csv"))

println(barcodes)

val manifest = (spark.read.format("csv")
        .option("header", "true")
        .load("./manifest.csv"))

println(manifest)

object Hamming {
  def compute(s1: String, s2: String): Int = {
    if (s1.length != s2.length)
      throw new IllegalArgumentException()
    (s1.toList).zip(s2.toList)
               .filter(current => current._1 != current._2)
               .length
  }
}

def hamming(sequence: String, bc: String): String = {
Hamming.compute(sequence.takeRight(bc.length()), bc).toString
}

val hammingUDF = udf[String, String, String](hamming)

val files = getListOfFiles(new File("./"), List("bam"))

val splitZA = udf((attributes:String) => {
  if (attributes.contains("ZA")) {attributes.toString.split("ZA:i:").last.split("\t")(0)
}
  else "0"
})


files.foreach(bam_path_temp => {
println(s"file is $bam_path_temp")
var bam_path = "./" + bam_path_temp.toString.split("/").last
var reads = sc.loadAlignments(bam_path)
var temp = manifest.join(barcodes, manifest("BC2") === barcodes("id"))
                   .filter(col("BC1") === ("A" + bam_path.split("IonXpress")(1).substring(2,4)))

// loop each barcode
temp.collect().par.foreach(bc_row => {
var bc_name = bc_row(7).toString + bc_row(8).toString
var bc_seq = bc_row(12)
println(bc_name.toString + "_" + bc_seq.toString)

reads
.toDF()
.withColumn("oldZA", splitZA($"attributes"))
.withColumn("ZA", $"oldZA" cast "Int" as "oldZA")
.withColumn("hamming", hammingUDF('sequence, lit(bc_seq)))
.withColumn("barcode", lit(bc_name.toString))
.withColumn("fileName", lit(bam_path.split("/").last))
.withColumn("seqLength", length($"sequence"))
.select($"fileName", $"mapq", $"ZA", $"barcode", $"readName", $"hamming", $"seqLength")
.write
.mode(SaveMode.Overwrite)
.option("header", "true")
.parquet("hamming_df/" + bc_name + "_" +  bam_path.split("/").last)
})})

//this is user editable

val min_hamming_temp = spark.read.parquet("hamming_df/*/*")

val windowSpec = Window.partitionBy(min_hamming_temp("readName")).orderBy(min_hamming_temp("hamming"))

val min_hamming_df = min_hamming_temp.withColumn("minHammingBarcode", first(min_hamming_temp("barcode")).over(windowSpec).as("minHammingBarcode")).filter("barcode = minHammingBarcode")

val read_summary_df = min_hamming_df.withColumn("passZA", when($"ZA" === $"seqLength", 1).otherwise(0)).withColumn("passHamming", when($"hamming" < 3 and $"ZA" === $"seqLength", 1).otherwise(0)).withColumn("passMap", when($"mapq" > 4 and $"hamming" < 3 and $"ZA" === $"seqLength", 1).otherwise(0)).groupBy("filename").agg(countDistinct('readName).alias("total reads"),sum($"passZA").alias("pass ZA reads"),sum($"passHamming").alias("pass hamming reads"),sum($"passMap").alias("pass mapq reads")).withColumn("pass za percent", bround($"pass za reads" / $"total reads", 2)).withColumn("pass hamming percent", bround($"pass hamming reads" / $"total reads", 2)).withColumn("pass mapq / final qualified percent", bround($"pass mapq reads" / $"total reads", 2)).orderBy($"pass mapq / final qualified percent")

read_summary_df.show

read_summary_df.coalesce(1).write.format("com.databricks.spark.csv").option("header", "true").mode("overwrite").save("read_summary_df.csv")


files.foreach(bam_path_temp => {

println(s"join is $bam_path_temp")

var bam_path = "./" + bam_path_temp.toString.split("/").last

var reads = sc.loadAlignments(bam_path)

var temp = manifest.join(barcodes, manifest("BC2") === barcodes("id"))
                   .filter(col("BC1") === ("A" + bam_path.split("IonXpress")(1).substring(2,4)))

//temp.collect().par.foreach(bc_row => {

temp.collect().foreach(bc_row => {



var bc_name = bc_row(7).toString + bc_row(8).toString
var bc_seq = bc_row(12)

println(bc_name.toString + "_" + bc_seq.toString)

var min_hamming_df_for_join = min_hamming_df
  .select($"barcode", $"readName".alias("minReadNameHamming"))
  .filter($"barcode" === bc_name)

reads.transformDataset(df => {

df.join(min_hamming_df_for_join,
        $"readName" === min_hamming_df_for_join("minReadNameHamming"))
  .drop("minReadNameHamming", "barcode")
  .as[org.bdgenomics.adam.sql.AlignmentRecord]
})
.saveAsSam(bam_path + "_demux/" + bc_name + "_" +  bam_path.split("/").last, asSingleFile=true)

})})



//command to exit spark shell
System.exit(0)


