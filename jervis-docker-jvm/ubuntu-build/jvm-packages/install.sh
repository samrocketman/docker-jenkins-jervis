#!/bin/bash
export PS4='$ '
echo "Setting up JVM packages"
set -x

apt-get install groovy gradle maven ant scala
