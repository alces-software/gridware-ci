if [[ ":$CW_DOCPATH" == *":$SORTMERNADIR"* ]]; then

  alces template copy sortmerna ~/sortmerna.sh

  /bin/bash -e -l ~/sortmerna.sh

else
  sortmerna --version
fi
