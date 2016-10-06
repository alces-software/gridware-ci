if [ -z "$CW_DOCPATH" ]; then
    :
else
    alces template prepare macs

    alces template copy macs ~/macs.sh

    /bin/bash -e -l ~/macs.sh
fi
