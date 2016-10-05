if [ -z "$CW_DOCPATH" ]; then
  IMB-MPI1
else
  alces template copy imb-4proc ~/imb.sh
  /bin/bash -e -l ~/imb.sh
fi
