# install dependencies
deps=(apps-python-2.7.8 libs-atlas-3.10.2 libs-numpy-1.10.4 libs-scipy-0.17.0 apps-samtools-1.3 apps-star-2.5.2a)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done