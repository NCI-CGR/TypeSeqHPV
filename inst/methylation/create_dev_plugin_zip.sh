rm -R TypeSeqHPVMethyl-DEV
mkdir TypeSeqHPVMethyl-DEV

# ion torrent plugin specific files
cp inst/methylation/instance.html TypeSeqHPVMethyl-DEV/
cp inst/methylation/barcodes.csv TypeSeqHPVMethyl-DEV/
cp inst/methylation/demux_3prime_barcode_adam.scala TypeSeqHPVMethyl-DEV/
cp inst/methylation/launch.sh TypeSeqHPVMethyl-DEV/
cp inst/methylation/plan.html TypeSeqHPVMethyl-DEV/
cp inst/methylation/pluginsettings.json TypeSeqHPVMethyl-DEV/

# zip plugin package
zip -r TypeSeqHPVMethyl_Plugin_Dev.zip TypeSeqHPVMethyl-DEV
