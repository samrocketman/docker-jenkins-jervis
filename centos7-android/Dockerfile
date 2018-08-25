FROM jervis-centos7
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

USER root
WORKDIR /opt

RUN yum makecache fast && \
yum install -y mesa-libGL && \
yum clean all && \
rm -rf /tmp/*

RUN set -ex; \
SDK_TOOLS_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"; \
SDK_TOOLS_SHA256SUM="92ffee5a1d98d856634e8b71132e8a95d96c83a63fde1099be3d86df3106def9"; \
mkdir /opt/android-sdk && \
cd /opt/android-sdk && \
curl -Lo sdk-tools.zip "${SDK_TOOLS_URL}" && \
sha256sum -c <<< "${SDK_TOOLS_SHA256SUM}  sdk-tools.zip" && \
unzip sdk-tools.zip && \
rm -f sdk-tools.zip && \
chown -R jenkins. /opt/android-sdk

ADD android.sh /etc/profile.d/

USER jenkins
WORKDIR /home/jenkins
ENV JAVA_HOME /opt/oraclejdk8

RUN /bin/bash -exlc '\
mkdir ~/.android; \
touch ~/.android/repositories.cfg; \
yes | sdkmanager --licenses; \
yes | sdkmanager platform-tools emulator; \
yes | sdkmanager --update'

CMD /bin/bash

# Sample usage
#     yes | sdkmanager platform-tools emulator 'platforms;android-22' 'system-images;android-22;default;armeabi-v7a'
#     yes '' | avdmanager create avd --package 'system-images;android-22;default;armeabi-v7a' --abi armeabi-v7a --name android-22
#     adb start-server
#     nohup emulator -avd android-22 -no-skin -no-window &
