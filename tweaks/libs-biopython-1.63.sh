install_args="--variant=all"
export_args="--ignore-bad"
export_packages="libs/biopython/1.63 libs/biopython_python3/1.63"
# install dependencies
deps=(libs-atlas-3.10.2)
deps+=(apps-python-2.7.8 apps-python3-3.3.3 apps-setuptools-15.1 apps-setuptools_python3-15.1)
deps+=(libs-numpy-1.9.2 libs-numpy_python3-1.9.2)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
