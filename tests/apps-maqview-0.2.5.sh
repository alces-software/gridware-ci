if [[ ":$CW_DOCPATH" == *":$MAQVIEWDIR"* ]]; then

  alces template prepare maqview
     
  alces template copy maqview ~/maqview.sh

  /bin/bash -e -l ~/maqview.sh

else
  :
fi
