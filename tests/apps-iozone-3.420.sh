if [[ ":$CW_DOCPATH" == *":$IOZONEDIR"* ]]; then

  alces template copy iozone ~/iozone.sh

  /bin/bash -e -l ~/iozone.sh

else
  iozone -h
fi
