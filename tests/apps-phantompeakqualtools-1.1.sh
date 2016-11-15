if [[ ":$CW_DOCPATH" == *":$PHANTOMPEAKQUALTOOLSDIR"* ]]; then

  alces template copy phantompeakqualtools ~/phantompeakqualtools.sh

  /bin/bash -e -l ~/phantompeakqualtools.sh

else
  :
fi
