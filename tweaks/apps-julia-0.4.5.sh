export_args="--ignore-bad"
# install dependencies
deps=(apps-patchelf-0.8)
deps+=(libs-llvm-3.7.1)
deps+=(libs-pcre2-10.21)
deps+=(libs-openlibm-0.4.1)
deps+=(libs-openblas-0.2.15)
deps+=(libs-lapack-3.5.0)
deps+=(libs-fftw3_double-3.3.4)
deps+=(libs-suitesparse-4.5.1)
deps+=(mpi-openmpi-1.8.5)
deps+=(libs-arpack-ng-3.3.0)
deps+=(libs-libgit2-0.23.4)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
