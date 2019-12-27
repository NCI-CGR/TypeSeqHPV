rm -R TypeSeq2-Dev
mkdir TypeSeq2-Dev

# ion torrent plugin specific files
cp inst/typeseq2/instance.html TypeSeq2-Dev/
cp inst/typeseq2/launch.sh TypeSeq2-Dev/
cp inst/typeseq2/plan.html TypeSeq2-Dev/
cp inst/typeseq2/pluginsettings.json TypeSeq2-Dev/

# zip plugin package
zip -r TypeSeq2-Dev.zip TypeSeq2-Dev