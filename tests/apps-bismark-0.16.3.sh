if [[ ":$CW_DOCPATH" == *":$BISMARKDIR"* ]]; then

  alces template copy bismark ~/bismark.sh

  /bin/bash -e -l ~/bismark.sh

else
  bismark --version
fi
