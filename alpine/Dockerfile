#https://github.com/anapsix/docker-alpine-java
FROM anapsix/alpine-java:8_jdk

RUN adduser -h /home/jenkins -S jenkins && \
apk add --no-cache bash git rsync openssh ca-certificates curl wget && \
mkdir -p /home/jenkins/java/ && \
ln -s /opt/jdk /home/jenkins/java/openjdk8 && \
wget -O /dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
echo '057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945  /dumb-init' | sha256sum -c - && \
chmod 755 /dumb-init

ENTRYPOINT ["/dumb-init", "--"]
USER jenkins
ENV JAVA_HOME="/opt/jdk"
CMD /bin/bash
