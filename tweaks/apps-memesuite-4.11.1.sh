# mpi variant disabled from CI for now due to alces-software/packager-base#80
#install_args="--variant=all"
#export_packages="apps/memesuite/4.11.1 apps/memesuite_mpi/4.11.1"
install_args="--variant=default"
export_args="--ignore-bad"
export_packages="apps/memesuite/4.11.1"
# install dependencies
deps=(mpi-openmpi-1.8.5 apps-perl-5.20.2 apps-cpanminus-1.5017 apps-python-2.7.8)
for dep in "${deps[@]}"; do
    docker run ${img}:build /bin/bash -c "curl -L https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist/${dep}-${cw_DIST}.tar.gz > /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
    docker run ${img}:build /bin/bash -l -c "alces gridware import /tmp/${dep}-${cw_DIST}.tar.gz"
    docker commit $(docker ps -alq) $img:build
done
# hack perl module to mitigate alces-software/packager-base#77
docker run ${img}:build /bin/bash -l -c "echo -e 'append-path PERL5LIB ${appdir}/lib/site_perl/5.20.2/x86_64-linux\nappend-path PERL5LIB ${appdir}/lib/site_perl/5.20.2\nappend-path PERL5LIB ${appdir}/lib/5.20.2/x86_64-linux\nappend-path PERL5LIB ${appdir}/lib/5.20.2' >> /opt/gridware/local/${cw_DIST}/etc/modules/apps/perl/5.20.2/*"
docker commit $(docker ps -alq) $img:build
