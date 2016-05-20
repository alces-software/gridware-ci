#!/bin/bash
set -e
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
    if [ "$1" == "main" ]; then
        prefix="main"
    else
        prefix="volatile"
    fi
    echo "Logs were uploaded to S3. See:"
    echo ""
    echo "https://console.aws.amazon.com/s3/home?region=eu-west-1#&bucket=packages.alces-software.com&prefix=gridware_builds/${prefix}-${TRAVIS_BUILD_NUMBER}/${TRAVIS_JOB_NUMBER}"
else
    cd "$HOME/logs"
    for a in $(find . -type f); do
        echo -e "\n\n\n\n======================= $a\n\n"
        cat "$a"
    done
fi
