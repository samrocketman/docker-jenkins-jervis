#!/bin/bash
export PS4='$ '
echo "Setting up Jenkins client info"
set -x

#add jenkins user with sudo rights
adduser --quiet jenkins
echo "jenkins:jenkins" | chpasswd
usermod -a -G sudo jenkins
#install ssh public key
mkdir ~jenkins/.ssh
cp /build/jenkins/insecure_key.pub ~jenkins/.ssh/authorized_keys
#http://www.openssh.com/faq.html#3.14
chmod go-w ~jenkins ~jenkins/.ssh
chmod 600 ~jenkins/.ssh/authorized_keys
chown -R jenkins. ~jenkins/.ssh
