# export_args="--ignore-bad"
# install dependencies
deps=(apps-cpanminus-1.5017 apps-cmake-3.5.2 mpi-openmpi-1.8.5 apps-python-2.7.8 libs-boost-1.60.0 apps-samtools-0.1.18)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
