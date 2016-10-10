if [[ ":$CW_DOCPATH" == *":$BOWTIE2DIR"* ]]; then

  alces template copy bowtie2 ~/bowtie2.sh

  /bin/bash -e -l ~/bowtie2.sh

else
  bowtie2 -h
fi
