if [[ ":$CW_DOCPATH" == *":$MULTIZTBADIR"* ]]; then

  alces template prepare multiztba

  alces template copy multiztba ~/multiztba.sh

  /bin/bash -e -l ~/multiztba.sh

else
  :
fi
