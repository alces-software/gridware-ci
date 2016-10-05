if [ -z "$CW_DOCPATH" ]; then
  Trinity --cite
else
  alces template copy trinity ~/trinity.sh
  /bin/bash -e -l ~/trinity.sh
fi
