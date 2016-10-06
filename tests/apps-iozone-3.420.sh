if [ -z "$CW_DOCPATH" ]; then
    :
else
    alces template copy iozone ~/iozone.sh

    /bin/bash -e -l ~/iozone.sh
fi
