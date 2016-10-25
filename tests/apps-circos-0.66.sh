if [[ ":$CW_DOCPATH" == *":$CIRCOSDIR"* ]]; then

  alces template copy circos ~/circos.sh

  /bin/bash -e -l ~/circos.sh

else
  :
fi
