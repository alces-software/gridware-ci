if [[ ":$CW_DOCPATH" == *":$IMBDIR"* ]]; then

  alces template copy imb-4proc ~/imb.sh

  /bin/bash -e -l ~/imb.sh

else
  IMB-MPI1
fi
