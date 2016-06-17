install_args="--variant=all"
export_packages="libs/fftw2_float/2.1.5 libs/fftw2_double/2.1.5 libs/fftw2_float-mpi/2.1.5 libs/fftw2_double-mpi/2.1.5"
# install dependencies
deps=(mpi-openmpi-1.8.5)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
