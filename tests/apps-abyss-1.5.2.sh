if [[ ":$CW_DOCPATH" == *":$ABYSSDIR"* ]]; then

  alces template prepare abyss

  alces template copy abyss ~/abyss.sh

  /bin/bash -e -l ~/abyss.sh

else
  abyss -h
fi
