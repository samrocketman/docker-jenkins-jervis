#!/bin/bash
export PS4='$ '
echo "Setting up RVM."

su - jenkins -c 'gpg --import - < /build/rvm-packages/keys.asc'
su - jenkins -c 'bash -s stable < /build/rvm-packages/get.rvm.io'
su - jenkins -c 'rvm get stable'
