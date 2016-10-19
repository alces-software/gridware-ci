if [[ ":$CW_DOCPATH" == *":$EXPRESSDIR"* ]]; then

  alces template copy express ~/express.sh

  /bin/bash -e -l ~/express.sh

else
  :
fi
