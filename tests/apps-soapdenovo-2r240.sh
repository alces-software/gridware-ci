if [ -z "$CW_DOCPATH" ]; then
  SOAPdenovo-127mer
else
  alces template prepare soapdenovo
  alces template copy soapdenovo ~/soapdenovo.sh
  /bin/bash -e -l ~/soapdenovo.sh
fi
