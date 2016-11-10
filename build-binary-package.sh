#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <package name>"
    echo " e.g. $0 apps/samtools/0.1.19"
    exit 1
fi
pkg=$1
if ! systemctl is-active docker; then
    yum install -y docker
    systemctl start docker
fi
if [ ! -d /opt/gridware-ci-volatile ]; then
    mkdir -p /opt/gridware-ci-volatile
    cd /opt/gridware-ci-volatile
    git clone https://github.com/alces-software/packager-base
    cd packager-base
    git clone https://github.com/alces-software/gridware-ci .gridware-ci
else
    cd /opt/gridware-ci-volatile/packager-base
fi
if [ -z "$(docker images -q gridware-ci-volatile)" ]; then
    docker build --build-arg treeish=master --build-arg repo_slug=alces-software/packager-base \
       -t "gridware-ci-volatile" \
       .gridware-ci/el7-1.6
fi
img="gridware-ci-volatile"
cw_DIST=el7
nicename="$(echo "$pkg" | tr '/' '-')"
if [ -f .gridware-ci/tweaks/${nicename}.sh ]; then
    . .gridware-ci/tweaks/${nicename}.sh
fi
log_output="$HOME/logs/${nicename}.$(date +%Y%m%d-%H%M%S)"
build_output="$HOME"/dist
mkdir -p "${log_output}" "${build_output}"
docker run $img /bin/bash -l -c "alces gridware install --yes --non-interactive --binary-depends ${pkg} ${install_args}"
docker commit $(docker ps -alq) $img:installed
if [ $? -gt 0 ]; then
    echo "Failed :-("
else
    for b in ${export_packages:-${pkg}}; do
        docker commit $(docker ps -alq) $img:installed
        docker run ${img}:installed /bin/bash -l -c "alces gridware export --non-interactive --accept-elf ${export_args} ${b}"
        if [ $? -gt 0 ]; then
            echo "Failed :-("
            exit 1
        fi
    done
fi
ctr=$(docker ps -alq)
docker cp ${ctr}:/var/log/gridware "${log_output}"
docker cp ${ctr}:/root/.cpanm/build.log "${log_output}"/cpanm-build.log.$(date +%Y%m%d%H%M%S)
for b in ${export_packages:-${pkg}}; do
    nicename="$(echo "$b" | tr '/' '-')"
    docker cp ${ctr}:/tmp/${nicename}-${cw_DIST}.tar.gz "${build_output}"
done
docker rm ${ctr}
docker rmi $img:installed
