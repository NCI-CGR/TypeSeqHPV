rm -R TypeSeq2
mkdir TypeSeq2

# ion torrent plugin specific files
cp inst/typeseq2/instance.html TypeSeq2/
cp inst/typeseq2/launch.sh TypeSeq2/
cp inst/typseq2/plan.html TypeSeq2/
cp inst/typeseq2/pluginsettings.json TypeSeq2/

# zip plugin package
zip -r TypeSeq2.zip TypeSeq2
