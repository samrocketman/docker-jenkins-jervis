FROM ubuntu:22.04
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

# add config files
ADD 90jervis-apt /etc/apt/apt.conf.d/90jervis
ADD 90jervis-sudoers /etc/sudoers.d/90jervis

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]
RUN \
  apt-get update; \
  # base packages
  apt install -y sudo; \
  # language: python
  apt-get install -y python3 python3.11 python3-venv python3.11-venv; \
  # language: java
  apt-get install -y openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk openjdk-18-jdk openjdk-19-jdk; \
  # toolchain: docker
  apt-get install -y ca-certificates curl gnupg; \
  install -m 0755 -d /etc/apt/keyrings; \
  curl -sSfL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg; \
  chmod a+r /etc/apt/keyrings/docker.gpg; \
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" \
    > /etc/apt/sources.list.d/docker.list; \
  apt-get update; \
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; \
  # clean up
  apt-get clean; \
  rm -rf /tmp/* /var/tmp/*; \
  rm -rf /var/lib/apt/lists/*; \
  rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# install binaries from custom releases
ADD download-utilities.yml /usr/local/
RUN \
  curl -sSfLo /usr/local/bin/download-utilities.sh \
    https://raw.githubusercontent.com/samrocketman/yml-install-files/main/download-utilities.sh; \
  chmod 755 /usr/local/bin/download-utilities.sh; \
  /usr/local/bin/download-utilities.sh /usr/local/download-utilities.yml

# set up Jenkins user
RUN \
  useradd -m -s /bin/bash -G sudo,docker -d /home/jenkins jenkins; \
  chown -R jenkins. /usr/local

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
USER jenkins
WORKDIR /home/jenkins
CMD ["/bin/bash", "-l"]
