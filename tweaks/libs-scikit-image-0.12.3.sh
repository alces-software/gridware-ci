install_args="--variant=all"
export_packages="libs/scikit-image/0.12.3 libs/scikit-image_python3/0.12.3 libs/scikit-image_python34/0.12.3"
# install dependencies
deps=(apps-python-2.7.8 apps-python3-3.3.3 apps-python3-3.4.3 libs-atlas-3.10.2 libs-numpy-1.9.2 libs-numpy_python3-1.9.2 libs-numpy_python34-1.9.2 libs-scipy-0.17.0 libs-scipy_python3-0.17.0 libs-scipy_python34-0.17.0 apps-setuptools-2.1 apps-setuptools_python3-2.1 apps-setuptools_python34-2.1 libs-matplotlib-1.4.3 libs-matplotlib_python3-1.4.3 libs-matplotlib_python34-1.4.3 apps-cython-0.23.4 apps-cython_python3-0.23.4 apps-cython_python34-0.23.4)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
