FROM alces/clusterware-el7:1.7
MAINTAINER Alces Software Ltd <support@alces-software.com>

ARG --description="tree under test" treeish
ARG --description="repo under test" repo_slug

RUN /opt/clusterware/bin/alces service install gridware && /opt/clusterware/bin/alces gridware init && yum clean all
RUN /opt/clusterware/bin/alces service install clusterware-storage && yum clean all
RUN rm -rf /opt/clusterware/var/lib/gridware/repos/main
RUN /opt/clusterware/opt/git/bin/git clone https://github.com/$repo_slug /opt/clusterware/var/lib/gridware/repos/main
RUN cd /opt/clusterware/var/lib/gridware/repos/main && /opt/clusterware/opt/git/bin/git checkout ${treeish} || true
RUN sed -i -e 's,:default_binary_url:.*,:default_binary_url: https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24dist,g' /opt/gridware/etc/gridware.yml
RUN /opt/clusterware/bin/alces storage enable http
RUN bash -c 'mkdir -p /etc/xdg/clusterware/storage && echo cw_STORAGE_http_base_url="https://s3-eu-west-1.amazonaws.com/packages.alces-software.com/gridware/%24data" > /etc/xdg/clusterware/storage/gridware-data.http.rc'
RUN useradd testuser

CMD ["/bin/bash"]
