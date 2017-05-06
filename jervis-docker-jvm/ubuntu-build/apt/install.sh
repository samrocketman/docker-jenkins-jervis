#!/bin/bash
export PS4='$ '
echo "Setting up APT"
set -x
cp /build/apt/90jervis /etc/apt/apt.conf.d/90jervis
chown root. /etc/apt/apt.conf.d/90jervis
chmod 644 /etc/apt/apt.conf.d/90jervis
apt-get update
#apt-get upgrade
apt-get install \
  ca-certificates \
  ca-certificates-java \
  curl \
  dnsutils \
  git \
  netcat \
  sudo \
  unzip \
  zip \

#cleaning up
apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
