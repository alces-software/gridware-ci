install_args="--variant=all"
export_args="--ignore-bad"
export_packages="libs/opencv/2.4.9 libs/opencv_tbb/2.4.9"
# install dependencies
deps=(apps-cmake-3.4.3)
deps+=(apps-python-2.7.8 apps-setuptools-15.1)
deps+=(libs-atlas-3.10.2 libs-numpy-1.9.2)
deps+=(libs-eigen-3.2.4 apps-ffmpeg-1.2.1)
deps+=(libs-tbb-4.4.20160128)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
