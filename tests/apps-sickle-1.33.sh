if [[ ":$CW_DOCPATH" == *":$SICKLEDIR"* ]]; then

  alces template copy sickle-se ~/sickle-se.sh

  /bin/bash -e -l ~/sickle-se.sh

  alces template copy sickle-pe-1 ~/sickle-pe-1.sh

  /bin/bash -e -l ~/sickle-pe-1.sh

else
  sickle --version
fi
