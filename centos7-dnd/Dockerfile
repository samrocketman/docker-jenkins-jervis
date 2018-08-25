FROM jervis-centos7
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

USER root
WORKDIR /root

# Install latest Docker CE for CentOS 7
RUN set -ex; \
yum makecache fast && \
yum install -y yum-utils device-mapper-persistent-data lvm2 && \
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
yum makecache fast && \
yum install docker-ce && \
yum clean all && \
rm -rf /tmp/*

# Give Jenkins user docker permissions
RUN usermod -a -G docker jenkins

USER jenkins
WORKDIR /home/jenkins

CMD /bin/bash
