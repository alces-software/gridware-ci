if [[ ":$CW_DOCPATH" == *":$PAMLDIR"* ]]; then

  alces template copy paml ~/paml.sh

  /bin/bash -e -l ~/paml.sh

else
  :
fi
