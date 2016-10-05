if [ -z "$CW_DOCPATH" ]; then
  STAR
else
  alces template prepare star
  alces template copy star ~/star.sh
  /bin/bash -e -l ~/star.sh
fi
