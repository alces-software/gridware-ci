#!/bin/bash
set -ex
sudo service docker stop
sudo apt-get update
sudo apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::="--force-confnew" install docker-engine
REPO="${TRAVIS_REPO_SLUG}"
if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
    TREEISH="${TRAVIS_COMMIT}"
else
    TREEISH="$(git rev-parse HEAD^2)"
fi
docker build --build-arg treeish=${TREEISH} --build-arg repo_slug="${REPO}" \
       -t "alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}" \
       ".gridware-ci/${cw_DIST}-${cw_VERSION}"
