if [[ ":$CW_DOCPATH" == *":$MIRADIR"* ]]; then

  alces template prepare mira

  alces template copy mira ~/mira.sh

  /bin/bash -e -l ~/mira.sh

else
  mira -version
fi
