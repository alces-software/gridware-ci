#!/bin/bash
export ARTIFACTS_REGION='eu-west-1'
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
    if [ "$TRAVIS_BRANCH" == "master" -a "$TRAVIS_PULL_REQUEST" == "false" ]; then
        artifacts -f multiline upload \
	          --permissions=public-read \
	          --target-paths 'gridware' \
	          --working-dir "$HOME" \
	          '$dist'
    fi
    artifacts -f multiline upload \
	      --target-paths 'gridware_builds' \
	      --working-dir "$HOME/logs" \
              build-$TRAVIS_BUILD_NUMBER
else
    echo "Skipping artifact upload as we don't appear to have secure env vars set."
fi
