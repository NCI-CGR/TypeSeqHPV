rm -r TypeSeqHPV-TSv1-DEV
mkdir TypeSeqHPV-TSv1-DEV

# ion torrent plugin specific files
cp inst/ion_plugin_specific_files/instance.html TypeSeqHPV-TSv1-DEV
cp inst/ion_plugin_specific_files/launch.sh TypeSeqHPV-TSv1-DEV
cp inst/ion_plugin_specific_files/plan.html TypeSeqHPV-TSv1-DEV
cp inst/ion_plugin_specific_files/pluginsettings.json TypeSeqHPV-TSv1-DEV

# zip plugin package
zip -r TypeSeqHPV_TSv1_Ion_Torrent_Plugin_Dev.zip TypeSeqHPV-TSv1-DEV
