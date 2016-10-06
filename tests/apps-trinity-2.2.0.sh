if [[ ":$CW_DOCPATH" == *":$TRINITYDIR"* ]]; then
  alces template copy trinity ~/trinity.sh
  /bin/bash -e -l ~/trinity.sh
else
    Trinity --cite
fi
