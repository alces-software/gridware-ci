if [[ ":$CW_DOCPATH" == *":$HAPFLKDIR"* ]]; then

  alces template prepare hapflk

  alces template copy hapflk ~/hapflk.sh

  /bin/bash -e -l ~/hapflk.sh

else
  hapflk --help
fi
