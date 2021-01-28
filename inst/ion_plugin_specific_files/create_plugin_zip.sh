rm -r TypeSeqHPV_V1_controls
mkdir TypeSeqHPV_V1_controls

# ion torrent plugin specific files
cp inst/ion_plugin_specific_files/instance.html TypeSeqHPV_V1_controls
cp inst/ion_plugin_specific_files/launch.sh TypeSeqHPV_V1_controls
cp inst/ion_plugin_specific_files/plan.html TypeSeqHPV_V1_controls
cp inst/ion_plugin_specific_files/pluginsettings.json TypeSeqHPV_V1_controls

# zip plugin package
zip -r TypeSeqHPV_V1_controls.zip TypeSeqHPV_V1_controls
