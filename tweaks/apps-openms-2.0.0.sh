install_args="--variant=default"
# install dependencies
deps=(libs-atlas-3.10.2 apps-cmake-3.5.2 mpi-openmpi-1.8.5 apps-python-2.7.8 apps-setuptools-15.1 libs-eigen-3.2.4 libs-seqan-1.4.1 libs-boost-1.60.0 apps-cython-0.23.4 libs-numpy-1.9.2)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
