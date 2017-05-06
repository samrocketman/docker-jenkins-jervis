#!/bin/bash
export PS4='$ '
echo "Setting up Jenkins client info"
set -x

#add jenkins user with sudo rights
adduser --quiet jenkins
usermod -a -G sudo jenkins
