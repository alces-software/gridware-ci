if [[ ":$CW_DOCPATH" == *":$FGWASDIR"* ]]; then

  alces template copy fgwas ~/fgwas.sh

  /bin/bash -e -l ~/fgwas.sh

else
  :
fi
