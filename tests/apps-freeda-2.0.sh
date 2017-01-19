if [[ ":$CW_DOCPATH" == *":$FREEDADIR"* ]]; then

  alces template copy freeda ~/freeda.sh

  /bin/bash -e -l ~/freeda.sh

else
  :
fi
