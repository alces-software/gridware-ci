install_args="--variant=all"
export_packages="libs/scikitlearn/0.18.1 libs/scikitlearn_python3/0.18.1 libs/scikitlearn_python34/0.18.1"
# install dependencies
deps=(libs-atlas-3.10.2)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
