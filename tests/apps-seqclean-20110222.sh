if [[ ":$CW_DOCPATH" == *":$SEQCLEANDIR"* ]]; then

  alces template copy seqclean ~/seqclean.sh

  /bin/bash -e -l ~/seqclean.sh

else
  :
fi
