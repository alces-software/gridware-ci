if [[ ":$CW_DOCPATH" == *":$MUSCLEDIR"* ]]; then

  alces template prepare muscle

  alces template copy muscle ~/muscle.sh

  /bin/bash -e -l ~/muscle.sh

else
  muscle -version
fi
