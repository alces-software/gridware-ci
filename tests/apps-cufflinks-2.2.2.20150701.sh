if [[ ":$CW_DOCPATH" == *":$CUFFLINKSDIR"* ]]; then

  alces template prepare cufflinks

  alces template copy cufflinks ~/cufflinks.sh

  /bin/bash -e -l ~/cufflinks.sh

else
  cufflinks -h
fi
