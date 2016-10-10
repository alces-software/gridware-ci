if [[ ":$CW_DOCPATH" == *":$FASTQCDIR"* ]]; then

  alces template prepare fastqc

  alces template copy fastqc ~/fastqc.sh

  /bin/bash -e -l ~/fastqc.sh

else
  fastqc -v
fi
