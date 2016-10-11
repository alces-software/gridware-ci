if [[ ":$CW_DOCPATH" == *":$MACSDIR"* ]]; then

  alces template prepare macs

  alces template copy macs ~/macs.sh

  /bin/bash -e -l ~/macs.sh

else
  :
fi
