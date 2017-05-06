#!/bin/bash
export PS4='$ '
echo "Setting up RVM."

su - jenkins -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
su - jenkins -c 'bash -s stable < /build/rvm-packages/get.rvm.io'
su - jenkins -c 'rvm get stable'
