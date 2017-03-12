#!/bin/bash
export PS4='$ '
echo "Setting up SSH"
set -x

#apt-get install openssh-server
rm -f /etc/service/sshd/down
sed -i 's#\(session\s\+\)required\(\s\+pam_loginuid.so\)#\1optional\2#g' /etc/pam.d/sshd
mkdir -p /var/run/sshd
