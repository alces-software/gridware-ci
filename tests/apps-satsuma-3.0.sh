if [[ ":$CW_DOCPATH" == *":$SATSUMADIR"* ]]; then

  alces template copy satsuma ~/satsuma.sh

  /bin/bash -e -l ~/satsuma.sh

else
  $SATSUMABIN/Satsuma --help
fi
