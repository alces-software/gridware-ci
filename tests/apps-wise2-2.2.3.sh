if [[ ":$CW_DOCPATH" == *":$WISE2DIR"* ]]; then

  alces template copy wise2 ~/wise2.sh

  /bin/bash -e -l ~/wise2.sh

else
  :
fi
