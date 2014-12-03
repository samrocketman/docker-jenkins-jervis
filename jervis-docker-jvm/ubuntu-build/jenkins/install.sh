#!/bin/bash
export PS4='$ '
echo "Setting up Jenkins client info"
set -x

#jenkins client requires java
apt-get install --no-install-recommends openjdk-7-jdk

#add jenkins user with sudo rights
adduser --quiet jenkins
echo "jenkins:jenkins" | chpasswd
usermod -a -G sudo jenkins
