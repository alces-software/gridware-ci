if [[ ":$CW_DOCPATH" == *":$OASESDIR"* ]]; then

  alces template prepare oases-1

  alces template copy oases-1 ~/oases-1.sh

  /bin/bash -e -l ~/oases-1.sh

else
  oases --help
fi
