install_args="--variant=all"
export_packages="libs/netcdffortran/4.4.4 libs/netcdffortran_mpi/4.4.4"
export_args="--accept-bad 'lib/lib*.a'"
# install dependencies
deps=(apps-hdf5_mpi-1.8.13)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
