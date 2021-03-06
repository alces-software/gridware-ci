install_args="--variant=all"
export_args="--ignore-bad"
export_packages="libs/fftw3_float/3.3.4 libs/fftw3_double/3.3.4 libs/fftw3_long-double/3.3.4"
# install dependencies
deps=(mpi-openmpi-1.8.5)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
