FROM alces/clusterware-el6:1.6-dev
MAINTAINER Alces Software Ltd <support@alces-software.com>

ARG --description="tree under test" treeish
ARG --description="repo under test" repo_slug

RUN rm -rf /opt/clusterware/var/lib/gridware/repos/volatile/pkg
RUN /opt/clusterware/opt/git/bin/git clone https://github.com/$repo_slug /opt/clusterware/var/lib/gridware/repos/volatile/pkg
RUN cd /opt/clusterware/var/lib/gridware/repos/volatile/pkg && /opt/clusterware/opt/git/bin/git checkout ${treeish} || true
RUN sed -i -e 's, - /opt/clusterware/var/lib/gridware/repos/main,# - /opt/clusterware/var/lib/gridware/repos/main,g' /opt/gridware/etc/gridware.yml
RUN sed -i -e 's,# - /opt/clusterware/var/lib/gridware/repos/volatile, - /opt/clusterware/var/lib/gridware/repos/volatile,g' /opt/gridware/etc/gridware.yml

CMD ["/bin/bash"]
