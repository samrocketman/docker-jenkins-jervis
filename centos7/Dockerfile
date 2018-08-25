FROM centos:7.3.1611
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

ADD yum.conf /etc/

# Install dependent repositories
# EPEL - https://fedoraproject.org/wiki/EPEL
# IUS  - https://ius.io/
RUN set -ex; \
chown root. /etc/yum.conf && \
chmod 644 /etc/yum.conf && \
yum makecache fast && \
yum install epel-release && \
curl -Lo /tmp/ius.asc https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY && \
echo '688852e2dba88a3836392adfc5a69a1f46863b78bb6ba54774a50fdecee7e38e  /tmp/ius.asc' | sha256sum -c - && \
rpm --import /tmp/ius.asc && \
curl -Lo /tmp/ius-release.rpm https://rhel7.iuscommunity.org/ius-release.rpm && \
rpm --checksig /tmp/ius-release.rpm && \
rpm -i /tmp/ius-release.rpm && \
yum clean all && \
rm -rf /tmp/*

################################################################################
# Install packages, upgrade git because it's too old for Jenkins, and fix locale
RUN set -ex; \
yum makecache fast && \
yum erase -y git && \
yum install git2u intltool glibc-common unzip sudo nmap-ncat bind-utils && \
# reinstall glibc-common as a language hack
yum reinstall glibc-common && \
localedef -i en_US -f UTF-8 en_US.UTF-8 && \
tee /etc/sysconfig/i18n <<<'"LANG=en_US.UTF-8"' && \
yum clean all && \
rm -rf /tmp/*

# Addional locale fix
ENV LANG=en_US.UTF-8 \
LC_ALL=en_US.UTF-8

# Install Oracle JDK 8 with Unlimited JCE
RUN \
JAVA8_ARCHIVE="http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz"; \
JAVA8_SHASUM="1845567095bfbfebd42ed0d09397939796d05456290fb20a83c476ba09f991d3"; \
JAVA8_JCE="http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"; \
JAVA8_JCE_SHASUM="f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59"; \
mkdir -p /opt/oraclejdk8 && \
cd /opt/oraclejdk8/ && \
curl -H 'Cookie: oraclelicense=accept-securebackup-cookie' -Lo /opt/oraclejdk8.tar.gz "${JAVA8_ARCHIVE}" && \
sha256sum -c - <<< "${JAVA8_SHASUM}  /opt/oraclejdk8.tar.gz" && \
tar --strip-components 1 -xzf /opt/oraclejdk8.tar.gz && \
rm -f /opt/oraclejdk8.tar.gz && \
cd /opt/ && \
curl -H 'Cookie: oraclelicense=accept-securebackup-cookie' -LO  "${JAVA8_JCE}" && \
sha256sum -c <<< "${JAVA8_JCE_SHASUM}  jce_policy-8.zip" && \
unzip -o jce_policy-8.zip && \
mv -f ./UnlimitedJCEPolicyJDK8/* /opt/oraclejdk8/jre/lib/security/ && \
rm -rf jce_policy-8.zip UnlimitedJCEPolicyJDK8 && \
yum clean all && \
rm -rf /tmp/*

RUN yum makecache fast && \
yum install -y python2-pip && \
yum clean all && \
pip install -U pip && pip install virtualenv

# Don't require TTY, allow passwordless sudo
RUN sed -ri -- 's/Defaults(\s+)requiretty/#Defaults\1requiretty/' /etc/sudoers && \
sed -ri -- 's/#\s+(%wheel.+NOPASSWD: ALL)/\1/' /etc/sudoers

# Fix for D-Bus issue
# failed to read machine uuid: Failed to open "/var/lib/dbus/machine-id"
# Required by Xvfb + Firefox
RUN dbus-uuidgen --ensure

# Create jenkins user
RUN useradd -m -s /bin/bash -G wheel -d /home/jenkins jenkins && \
chown -R jenkins. /usr/local

# Install container init process
RUN curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
echo '81231da1cd074fdc81af62789fead8641ef3f24b6b07366a1c34e5b059faf363  /usr/local/bin/dumb-init' | sha256sum -c - && \
chmod 755 /usr/local/bin/dumb-init

# Install Apache Maven 3.5.0
WORKDIR /opt
ADD maven.sh /etc/profile.d/
RUN chown root. /etc/profile.d/maven.sh && \
chmod 644 /etc/profile.d/maven.sh && \
curl -LO https://www.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz && \
echo 'ce50b1c91364cb77efe3776f756a6d92b76d9038b0a0782f7d53acf1e997a14d  /opt/apache-maven-3.5.4-bin.tar.gz' | sha256sum -c - && \
tar xzvf apache-maven-3.5.4-bin.tar.gz && \
chown -R jenkins. apache-maven-3.5.4/ && \
rm -f apache-maven-3.5.4-bin.tar.gz

ADD init.gradle /home/jenkins/.gradle/

RUN chown -R jenkins. /home/jenkins/.gradle/

USER jenkins
WORKDIR /home/jenkins
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
