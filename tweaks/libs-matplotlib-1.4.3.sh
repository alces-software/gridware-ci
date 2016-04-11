install_args="--variant=all"
export_packages="libs/matplotlib/1.4.3 libs/matplotlib_python3/1.4.3 libs/matplotlib_python34/1.4.3"
# install dependencies
deps=(apps-python-2.7.8 apps-python3-3.3.3 apps-python3-3.4.3 libs-atlas-3.10.2 libs-numpy-1.9.2 libs-numpy_python3-1.9.2 libs-numpy_python34-1.9.2 apps-setuptools-2.1 apps-setuptools_python3-2.1 apps-setuptools_python34-2.1)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
