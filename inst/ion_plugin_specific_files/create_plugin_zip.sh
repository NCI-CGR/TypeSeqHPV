rm -r TypeSeqHPV-TSv1
mkdir TypeSeqHPV-TSv1

# ion torrent plugin specific files
cp inst/ion_plugin_specific_files/instance.html TypeSeqHPV-TSv1
cp inst/ion_plugin_specific_files/launch.sh TypeSeqHPV-TSv1
cp inst/ion_plugin_specific_files/plan.html TypeSeqHPV-TSv1
cp inst/ion_plugin_specific_files/pluginsettings.json TypeSeqHPV-TSv1

# zip plugin package
zip -r TypeSeqHPV_TSv1_Ion_Torrent_Plugin.zip TypeSeqHPV-TSv1
