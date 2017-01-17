FROM alces/clusterware-el7:1.7
MAINTAINER Alces Software Ltd <support@alces-software.com>

ARG --description="tree under test" treeish
ARG --description="repo under test" repo_slug

RUN /opt/clusterware/bin/alces service install gridware && /opt/clusterware/bin/alces gridware init && yum clean all
RUN rm -rf /opt/clusterware/var/lib/gridware/repos/volatile/pkg
RUN /opt/clusterware/opt/git/bin/git clone https://github.com/$repo_slug /opt/clusterware/var/lib/gridware/repos/volatile/pkg
RUN cd /opt/clusterware/var/lib/gridware/repos/volatile/pkg && /opt/clusterware/opt/git/bin/git checkout ${treeish} || true
RUN cd /opt/clusterware/var/lib/gridware/repos/volatile/pkg && /opt/clusterware/opt/git/bin/git fetch origin +refs/pull/${treeish}/merge && /opt/clusterware/opt/git/bin/git checkout -qf FETCH_HEAD || true
RUN sed -i -e 's, - /opt/clusterware/var/lib/gridware/repos/main,# - /opt/clusterware/var/lib/gridware/repos/main,g' /opt/gridware/etc/gridware.yml
RUN sed -i -e 's,# - /opt/clusterware/var/lib/gridware/repos/volatile, - /opt/clusterware/var/lib/gridware/repos/volatile,g' /opt/gridware/etc/gridware.yml
RUN sed -i -e 's,:default_binary_url:.*,:default_binary_url: https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist,g' /opt/gridware/etc/gridware.yml

CMD ["/bin/bash"]
