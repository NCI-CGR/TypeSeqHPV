rm -R TypeSeqHPVMethyl-Dev
mkdir TypeSeqHPVMethyl-Dev

# ion torrent plugin specific files
cp inst/methylation/instance.html TypeSeqHPVMethyl-Dev/
cp inst/methylation/launch.sh TypeSeqHPVMethyl-Dev/
cp inst/methylation/plan.html TypeSeqHPVMethyl-Dev/
cp inst/methylation/pluginsettings.json TypeSeqHPVMethyl-Dev/

# zip plugin package
zip -r TypeSeqHPVMethyl-Dev_Plugin.zip TypeSeqHPVMethyl-Dev
