if [[ ":$CW_DOCPATH" == *":$CEGMADIR"* ]]; then

  alces template copy cegma ~/cegma.sh

  /bin/bash -e -l ~/cegma.sh

else
  :
fi
