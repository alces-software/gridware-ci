if [[ ":$CW_DOCPATH" == *":$LIBMHASHDIR"* ]]; then

  alces template prepare libmhash

  alces template copy libmhash ~/libmhash.sh

  /bin/bash -e -l ~/libmhash.sh

else
  nm $LIBMHASHLIB/libmhash.so | grep mhash_keygen
fi
