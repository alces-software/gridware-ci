if [[ ":$CW_DOCPATH" == *":$MAQVIEWDIR"* ]]; then

  alces template copy maqview ~/maqview.sh

  /bin/bash -e -l ~/maqview.sh

else
  :
fi
