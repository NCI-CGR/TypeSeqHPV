# pull latest github repo
rm -r TypeSeqHPV
mkdir TypeSeqHPV
cd TypeSeqHPV
git init
git pull https://github.com/cgrlab/TypeSeqHPV.git
cd ../
rm -r TypeSeqHPV-TSv1-DEV
mkdir TypeSeqHPV-TSv1-DEV
cd TypeSeqHPV-TSv1-DEV

# ion torrent plugin specific files
cp ../TypeSeqHPV/inst/extdata/ion_plugin_specific_files/instance.html ./
cp ../TypeSeqHPV/inst/extdata/ion_plugin_specific_files/launch.sh ./
cp ../TypeSeqHPV/inst/extdata/ion_plugin_specific_files/plan.html ./
cp ../TypeSeqHPV/inst/extdata/ion_plugin_specific_files/pluginsettings.json ./

# zip plugin package
cd ../
zip -r TypeSeqHPV_TSv1_Ion_Torrent_Plugin_Dev.zip TypeSeqHPV-TSv1-DEV
