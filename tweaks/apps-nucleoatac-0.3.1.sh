# install dependencies
deps=(apps-python-2.7.8 apps-cython-0.23.4 libs-atlas-3.10.2 libs-numpy-1.9.2 apps-setuptools-2.1 libs-scipy-0.17.0 libs-matplotlib-1.4.3 libs-pysam-0.8.3)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
