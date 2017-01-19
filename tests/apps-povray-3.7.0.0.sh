if [[ ":$CW_DOCPATH" == *":$POVRAYDIR"* ]]; then

  alces template copy povray ~/povray.sh

  /bin/bash -e -l ~/povray.sh

else
  povray --version
fi
