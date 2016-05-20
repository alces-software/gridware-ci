FROM alces/clusterware-el6:1.5
MAINTAINER Alces Software Ltd <support@alces-software.com>

ARG --description="tree under test" treeish
ARG --description="repo under test" repo_slug

RUN rm -rf /opt/clusterware/var/lib/gridware/repos/main
RUN /opt/clusterware/opt/git/bin/git clone https://github.com/$repo_slug /opt/clusterware/var/lib/gridware/repos/main
RUN cd /opt/clusterware/var/lib/gridware/repos/main && /opt/clusterware/opt/git/bin/git checkout ${treeish} || true

CMD ["/bin/bash"]
