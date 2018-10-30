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

val files = getListOfFiles(new File("./"), List("bam")).par
files.foreach(file_name => println(s"file is $file_name"))

// COMMAND ----------

files.foreach(bam_path_temp => {

println(s"file is $bam_path_temp")

var bam_path = bam_path_temp.toString

var reads = sc.loadAlignments(bam_path)

reads.transformDataset(_.filter($"sequence".contains("CTAAGGTAAC")))
.saveAsSam(bam_path + "_demux/" + "bc01_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("TAAGGAGAAC")))
.saveAsSam(bam_path + "_demux/" + "bc02_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("AAGAGGATTC")))
.saveAsSam(bam_path + "_demux/" + "bc03_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("TACCAAGATC")))
.saveAsSam(bam_path + "_demux/" + "bc04_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("CAGAAGGAAC")))
.saveAsSam(bam_path + "_demux/" + "bc05_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("CTGCAAGTTC")))
.saveAsSam(bam_path + "_demux/" + "bc06_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("TTCGTGATTC")))
.saveAsSam(bam_path + "_demux/" + "bc07_" + bam_path.split("/").last, asSingleFile=true)

reads.transformDataset(_.filter($"sequence".contains("TTCCGATAAC")))
.saveAsSam(bam_path + "_demux/" + "bc08_" + bam_path.split("/").last, asSingleFile=true)

})


//command to exit spark shell
System.exit(0)

