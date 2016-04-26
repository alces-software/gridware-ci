install_args="--variant=all"
export_packages="libs/pysam/0.8.3 libs/pysam_python3/0.8.3 libs/pysam_python34/0.8.3"
# install dependencies
deps=(apps-python-2.7.8 apps-python3-3.3.3 apps-python3-3.4.3 apps-setuptools-15.1 apps-setuptools_python3-15.1 apps-setuptools_python34-15.1 apps-cython-0.23.4 apps-cython_python3-0.23.4 apps-cython_python34-0.23.4)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
