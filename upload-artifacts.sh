#!/bin/bash
export ARTIFACTS_REGION='eu-west-1'
if [ "$TRAVIS_BRANCH" == "master" -a "$TRAVIS_PULL_REQUEST" == "false" ]; then
    artifacts -f multiline upload \
	      --permissions=public-read \
	      --target-paths 'gridware' \
	      --working-dir "$HOME" \
	      '$dist'
fi
artifacts -f multiline upload \
	  --target-paths 'gridware_builds' \
	  --working_dir "$HOME/logs" \
          build-$TRAVIS_BUILD_NUMBER
