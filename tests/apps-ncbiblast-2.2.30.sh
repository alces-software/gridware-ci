if [ -z "$CW_DOCPATH" ]; then
    :
else
    alces template prepare blast

    alces template copy blast ~/blast.sh

    /bin/bash -e -l ~/blast.sh
fi
