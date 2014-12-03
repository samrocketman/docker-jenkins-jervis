#!/bin/bash
export PS4='$ '
echo "Setting up APT"
set -x
cp /build/apt/90jervis /etc/apt/apt.conf.d/90jervis
chown root. /etc/apt/apt.conf.d/90jervis
chmod 644 /etc/apt/apt.conf.d/90jervis
apt-get update
apt-get upgrade
apt-get install git
