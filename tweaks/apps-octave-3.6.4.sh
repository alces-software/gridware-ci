# install dependencies
deps=(mpi-openmpi-1.8.5 libs-atlas-3.10.2 libs-suitesparse-4.2.1 apps-hdf5_serial-1.8.13 libs-fftw3_double-3.3.4 libs-fftw3_float-3.3.4)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done

