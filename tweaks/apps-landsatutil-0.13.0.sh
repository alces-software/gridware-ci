#export_args="--ignore-bad"
# install dependencies
install_args="--variant=default"
#export_packages="apps-landsatutil-0.13.0"
deps=(libs-atlas-3.10.2 apps-python-2.7.8 apps-pip-8.1.2 apps-setuptools-15.1 libs-numpy-1.10.4 libs-gdal-2.1.0 libs-scipy-0.17.0 libs-matplotlib-1.5.1 libs-scikit-image-0.12.3)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
