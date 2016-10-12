if [[ ":$CW_DOCPATH" == *":$ANGESDIR"* ]]; then

  alces template copy anges ~/anges.sh

  /bin/bash -e -l ~/anges.sh

else
  :
fi
