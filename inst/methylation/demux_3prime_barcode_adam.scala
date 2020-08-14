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
import org.bdgenomics.adam.models._

def getListOfFiles(dir: File, extensions: List[String]): List[File] = {
    dir.listFiles.filter(_.isFile).toList.filter { file =>
        extensions.exists(file.getName.endsWith(_))
    }
}

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

val splitZA = udf((attributes:String) => {
  if (attributes.contains("ZA")) {attributes.toString.split("ZA:i:").last.split("\t")(0)
}
  else "0"
})

val splitRG = udf((attributes:String) => {
  if (attributes.contains("RG")) {attributes.toString.split("RG:Z:").last.split("\t")(0)
}
  else "0"
})

val replace = udf((data: String , rep : String, newString: String) => {
  data.replaceAll(rep, newString)
})


val barcodes = (spark.read.format("csv").option("header", "true").
  load("barcodes.csv")).withColumnRenamed("sequence", "bc_sequence")

val manifest = (spark.read.format("csv").option("header", "true").load("manifest.csv"))


val barcodesJoined = manifest.join(barcodes, manifest("BC2") === barcodes("id")).
  withColumn("barcodeID", concat($"BC1", $"BC2")).
  select($"barcodeID", $"bc_sequence", $"BC1", $"BC2")

val readsTransform = sc.loadAlignments("*.bam").
transformDataset(temp => {

val df = temp.toDF().
  withColumn("oldZA", splitZA($"attributes")).
  withColumn("ZA", $"oldZA" cast "Int" as "oldZA").
  withColumn("seqLength", length($"sequence")).
  withColumn("passZA", when($"ZA" === $"seqLength", 1).otherwise(0)).
  withColumn("passMap", when($"mapq" > 4 and $"ZA" === $"seqLength", 1).
    otherwise(0)).
  withColumn("recordGroupSample", $"recordGroupSample" cast "String" as "recordGroupSample").
  withColumn("filename", $"recordGroupSample")


val read_summary_df = df.
  groupBy("filename").
  agg(countDistinct('readName).alias("total reads"),
      sum($"passZA").alias("pass ZA reads"),
      sum($"passMap").alias("pass mapq reads"))

val dfReturn = df.
  filter($"mapq" > 4 and $"ZA" === $"seqLength").
  join(barcodesJoined, hammingUDF(df("sequence"), barcodesJoined("bc_sequence")) < 1).
  withColumn("recordGroupSample", concat(lit("A"), $"recordGroupSample")).
  filter($"recordGroupSample" === $"BC1").
  withColumn("recordGroupSample", concat($"recordGroupSample", $"BC2")).
  withColumn("readName", concat($"recordGroupSample", lit(":"), $"readName")).
  withColumn("recordGroupName", concat($"RecordGroupSample", lit("."), $"recordGroupName")).
  withColumn("oldRG", splitRG($"attributes")).
  withColumn("attributes", replace($"attributes" , $"oldRG", $"recordGroupName"))

val read_summary_2_df = dfReturn.
  groupBy("filename").
  agg(countDistinct('readName).alias("pass hamming reads")).
  join(read_summary_df, "filename").
  withColumn("pass za percent", bround($"pass za reads" / $"total reads", 2)).
  withColumn("pass mapq percent", bround($"pass mapq reads" / $"total reads", 2)).
  withColumn("pass hamming percent / final qualified percent",
  bround($"pass hamming reads" / $"total reads", 2)).
  orderBy($"pass hamming percent / final qualified percent").
  select($"filename", $"total reads", $"pass za reads", $"pass mapq reads",
    $"pass hamming reads", $"pass za percent", $"pass mapq percent",
    $"pass hamming percent / final qualified percent").
  coalesce(1).
  write.
  format("com.databricks.spark.csv").
  option("header", "true").
  mode("overwrite").
  save("read_summary_df.csv")

dfReturn.
drop("oldZA", "ZA", "seqLength", "bc1", "oldRG", "barcodeID", "bc_sequence",
"BC2", "passZA", "passMap", "filename").
as[org.bdgenomics.adam.sql.AlignmentRecord]

})


val namesList = readsTransform.toDF.select($"recordGroupName").distinct

namesList.repartition(1).write.format("com.databricks.spark.csv").
  save("sampleNames")

val namesListArray = namesList.rdd.map(r => r(0)).collect()

val tempRGDictionary = RecordGroupDictionary(namesListArray.
map(x => new RecordGroup(x.toString.take(6), x.toString, None, None, None,
Some("TACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGATCGATGTACAGCTACGTACGTCTGAGCATCGA"))).
toSeq)

val programSteps = new org.bdgenomics.formats.avro.ProcessingStep

programSteps.id = "Methyl"
programSteps.programName = "Methylation plugin"

readsTransform.replaceRecordGroups(tempRGDictionary).sort.
replaceProcessingSteps(Seq(programSteps)).
saveAsSam("demux_reads.bam", asSingleFile=true)

//command to exit spark shell
System.exit(0)


