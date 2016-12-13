#!/bin/bash
set -ex
sudo service docker stop
sudo apt-get update
sudo apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::="--force-confnew" install docker-engine
sudo service docker start || true
REPO="${TRAVIS_REPO_SLUG}"
if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
    TREEISH="${TRAVIS_COMMIT}"
elif [ "${TRAVIS_PULL_REQUEST}" == "" ]; then
    TREEISH="$(git rev-parse HEAD^2)"
else
    TREEISH="${TRAVIS_PULL_REQUEST}"
fi
if [ "$1" == "main" ]; then
    docker build --build-arg treeish=${TREEISH} --build-arg repo_slug="${REPO}" \
           -t "alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}" \
           ".gridware-ci/${cw_DIST}-${cw_VERSION}-main"
else
    docker build --build-arg treeish=${TREEISH} --build-arg repo_slug="${REPO}" \
           -t "alces/packages-${TRAVIS_COMMIT}-${cw_DIST}-${cw_VERSION}" \
           ".gridware-ci/${cw_DIST}-${cw_VERSION}"
fi
