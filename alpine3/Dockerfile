FROM alpine:3
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

RUN apk add --no-cache sudo bash shadow curl
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

ADD 90jervis-sudoers /etc/sudoers.d/90jervis
RUN apk add --no-cache \
  docker docker-cli-buildx docker-cli-compose \
  python3 py3-virtualenv \
  openjdk11-jdk openjdk17-jdk

# install binaries from custom releases
ADD download-utilities.yml /usr/local/
RUN \
  curl -sSfLo /usr/local/bin/download-utilities.sh \
    https://raw.githubusercontent.com/samrocketman/yml-install-files/main/download-utilities.sh; \
  chmod 755 /usr/local/bin/download-utilities.sh; \
  /usr/local/bin/download-utilities.sh /usr/local/download-utilities.yml

# set up Jenkins user
RUN \
  useradd -m -s /bin/bash -G wheel,docker -d /home/jenkins jenkins; \
  chown -R jenkins. /usr/local

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
USER jenkins
WORKDIR /home/jenkins
CMD ["/bin/bash", "-l"]
