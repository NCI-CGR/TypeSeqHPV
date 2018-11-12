import org.apache.spark.sql.functions._
import org.apache.spark.SparkContext
import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.adam.rdd.variant._
import java.io.File
import sys.process._

def getListOfFiles(dir: File, extensions: List[String]): List[File] = {
    dir.listFiles.filter(_.isFile).toList.filter { file =>
        extensions.exists(file.getName.endsWith(_))
    }
}

val files = getListOfFiles(new File("./vcf"), List("vcf"))

files.foreach(file_name => println(s"file is $file_name"))

//main loop
files.foreach(vcf_path_temp => {

println(s"file is $vcf_path_temp")

var vcf_path = vcf_path_temp.toString

var variants = sc.loadVariants(vcf_path)

variants
.toDF.coalesce(1).write.json(vcf_path + "_json_temp/" + vcf_path.split("/").last + ".json")

})

//command to exit spark shell
System.exit(0)

