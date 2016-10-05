if [ -z "$CW_DOCPATH" ]; then
  tophat --version
else
  alces template prepare tophat
  alces template copy tophat ~/tophat.sh
  /bin/bash -e -l ~/tophat.sh
fi
