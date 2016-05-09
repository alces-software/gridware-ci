install_args="--variant=all"
export_args="--ignore-bad"
export_packages="apps/khmer/2.0 apps/khmer_python3/2.0 apps/khmer_python34/2.0"
# install dependencies
deps=(apps-python-2.7.8 apps-python3-3.3.3 apps-python3-3.4.3 apps-setuptools-15.1 apps-setuptools_python3-15.1 apps-setuptools_python34-15.1 apps-screed-0.9 apps-screed_python3-0.9 apps-screed_python34-0.9)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
