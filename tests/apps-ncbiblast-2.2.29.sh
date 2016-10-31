if [[ ":$CW_DOCPATH" == *":$NCBIBLASTDIR"* ]]; then

  alces template prepare blast

  alces template copy blast ~/blast.sh

  /bin/bash -e -l ~/blast.sh

else
  :
fi
