rm -R TypeSeqHPVMethyl
mkdir TypeSeqHPVMethyl

# ion torrent plugin specific files
cp inst/methylation/instance.html TypeSeqHPVMethyl/
cp inst/methylation/launch.sh TypeSeqHPVMethyl/
cp inst/methylation/plan.html TypeSeqHPVMethyl/
cp inst/methylation/pluginsettings.json TypeSeqHPVMethyl/

# zip plugin package
zip -r TypeSeqHPVMethyl_Plugin.zip TypeSeqHPVMethyl
