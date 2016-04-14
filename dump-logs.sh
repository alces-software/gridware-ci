#!/bin/bash
set -ex
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
    echo "Logs were uploaded to S3. See:"
    echo ""
    echo "https://console.aws.amazon.com/s3/home?region=eu-west-1#&bucket=packages.alces-software.com&prefix=gridware_builds/build_${TRAVIS_BUILD_NUMBER}/"
else
    cd "$HOME/logs"
    for a in $(find .); do
        echo -e "\n\n\n\n======================= $a\n\n"
        cat "$a"
    done
fi
