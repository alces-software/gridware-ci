if [[ ":$CW_DOCPATH" == *":$GERPDIR"* ]]; then

  alces template prepare gerp-1-compute-rs-score

  alces template copy gerp-1-compute-rs-score ~/gerp-1.sh

  /bin/bash -e -l ~/gerp-1.sh


  alces template prepare gerp-2-find-elements

  alces template copy gerp-2-find-elements ~/gerp-2.sh

  /bin/bash -e -l ~/gerp-2.sh

else
  gerpcol -h
fi
