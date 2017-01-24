if [[ ":$CW_DOCPATH" == *":$SCYTHEDIR"* ]]; then

  alces template prepare scythe

  alces template copy scythe ~/scythe.sh

  /bin/bash -e -l ~/scythe.sh

else
  scythe --version
fi
