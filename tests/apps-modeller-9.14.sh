if [[ ":$CW_DOCPATH" == *":$MODELLERDIR"* ]]; then

  alces template copy modeller ~/modeller.sh

  /bin/bash -e -l ~/modeller.sh

else
  :
fi
