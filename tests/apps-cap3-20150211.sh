if [[ ":$CW_DOCPATH" == *":$CAP3DIR"* ]]; then

  alces template copy cap3 ~/cap3.sh

  /bin/bash -e -l ~/cap3.sh

else
  :
fi
