import org.apache.spark.sql.functions._
import org.apache.spark.SparkContext
import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.adam.rdd.read.AlignmentRecordRDD
import org.bdgenomics.adam.sql.AlignmentRecord
import org.bdgenomics.adam.rdd.read.{ AlignmentRecordRDD, AnySAMOutFormatter }
import java.io.File
import sys.process._

def getListOfFiles(dir: File, extensions: List[String]): List[File] = {
    dir.listFiles.filter(_.isFile).toList.filter { file =>
        extensions.exists(file.getName.endsWith(_))
    }
}

println("pre barcodes")

val barcodes = (spark.read.format("csv")
        .option("header", "true")
        .load("/TypeSeqHPV/inst/methylation/barcodes.csv"))

println(barcodes)

val manifest = (spark.read.format("csv")
        .option("header", "true")
        .load("/mnt/manifest.csv"))

println(manifest)

println("post manifest")

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

files.foreach(file_name => println(s"file is $file_name"))

//main loop
files.foreach(bam_path_temp => {

println(s"file is $bam_path_temp")

var bam_path = bam_path_temp.toString

var reads = sc.loadAlignments(bam_path)

var temp = manifest.join(barcodes, manifest("BC2") === barcodes("id"))
                   .filter(col("BC1") === ("A" + bam_path.substring(13,15)))

temp.collect().foreach(bc_row => {

var bc_name = bc_row(7).toString + bc_row(8).toString
var bc_seq = bc_row(12)

println(bc_name.toString + "_" + bc_seq.toString)

reads.transformDataset(_.filter(
        hammingUDF('sequence, lit(bc_seq)) isin ("0", "1")))
    .saveAsSam(bam_path + "_demux/" + bc_name + "_" +  bam_path.split("/").last,
        asSingleFile=true)

})


})

//command to exit spark shell
System.exit(0)
