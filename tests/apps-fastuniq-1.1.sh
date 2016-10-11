f [[ ":$CW_DOCPATH" == *":$FASTUNIQDIR"* ]]; then

  alces template copy fastuniq ~/fastuniq.sh

  /bin/bash -e -l ~/fastuniq.sh

fi
