if [[ ":$CW_DOCPATH" == *":$GRINDERDIR"* ]]; then

  alces template prepare grinder

  alces template copy grinder ~/grinder.sh

  /bin/bash -e -l ~/grinder.sh

else
  grinder --help
fi
