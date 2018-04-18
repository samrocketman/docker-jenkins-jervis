FROM ubuntu:16.04
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

# add config files
ADD 90jervis-apt /etc/apt/apt.conf.d/90jervis
ADD 90jervis-sudoers /etc/sudoers.d/90jervis

# install prerequisite packages and configure existing
RUN chown root. /etc/apt/apt.conf.d/90jervis /etc/sudoers.d/90jervis && \
chmod 644 /etc/apt/apt.conf.d/90jervis && \
chmod 440 /etc/sudoers.d/90jervis && \
apt-get update && \
apt-get install ca-certificates ca-certificates-java curl dnsutils git netcat sudo unzip zip openjdk-8-jdk && \
apt-get clean && \
rm -rf /tmp/* /var/tmp/* && \
rm -rf /var/lib/apt/lists/* && \
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# setup Jenkins agent user and grant sudo
# link Java
RUN adduser --quiet jenkins && \
usermod -a -G sudo jenkins && \
su - jenkins -c -- bash -c ' \
set -e; \
mkdir "${HOME}"/java; \
ln -s /usr/lib/jvm/java-8-openjdk-amd64 "${HOME}/java/openjdk8"'


# install SDKMan! and SDKMan! packages under jenkins user
RUN curl -s "https://get.sdkman.io" | su - jenkins -c -- bash && \
su - jenkins -c -- bash -c ' \
set -e; \
source "${HOME}/.sdkman/bin/sdkman-init.sh"; \
yes | sdk install maven 3.3.9; \
yes | sdk install groovy 2.4.11; \
yes | sdk install gradle 3.5;'

# install RVM for ruby support
RUN su - jenkins -c -- bash -c ' \
set -e; \
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB; \
curl -sSL https://get.rvm.io | bash -s stable;' && \
su - jenkins -c -- bash -c 'rvm get stable'

# set up Go support
RUN curl -sL -o /usr/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme && chmod 755 /usr/bin/gimme

# container init
RUN curl -Lo /bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
bash -c 'sha256sum -c <<< "057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945  /bin/dumb-init"' && \
chmod 755 /bin/dumb-init

# default runtime environment
ENTRYPOINT ["/bin/dumb-init", "--"]
USER 'jenkins'
WORKDIR /home/jenkins
