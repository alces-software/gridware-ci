if [[ ":$CW_DOCPATH" == *":$RIBOPICKERDIR"* ]]; then

  alces template copy ribopicker ~/ribopicker.sh

  /bin/bash -e -l ~/ribopicker.sh

else
  ribopicker.pl -version
fi
