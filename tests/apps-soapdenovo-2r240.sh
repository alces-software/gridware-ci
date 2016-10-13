if [[ ":$CW_DOCPATH" == *":$SOAPDENOVODIR"* ]]; then

  alces template prepare soapdenovo

  alces template copy soapdenovo ~/soapdenovo.sh

  /bin/bash -e -l ~/soapdenovo.sh

else
  SOAPdenovo-127mer --help
fi
