install_args="--variant=all"
export_packages="libs/lasagne/20160403 libs/lasagne_python3/20160403 libs/lasagne_python34/20160403"
# install dependencies
deps=(libs-atlas-3.10.2)
deps+=(apps-python-2.7.8 apps-setuptools-15.1 libs-numpy-1.9.2 libs-scipy-0.17.0 libs-theano-0.8.0)
deps+=(apps-python3-3.3.3 apps-setuptools_python3-15.1 libs-numpy_python3-1.9.2 libs-scipy_python3-0.17.0 libs-theano_python3-0.8.0)
deps+=(apps-python3-3.4.3 apps-setuptools_python34-15.1 libs-numpy_python34-1.9.2 libs-scipy_python34-0.17.0 libs-theano_python34-0.8.0)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
