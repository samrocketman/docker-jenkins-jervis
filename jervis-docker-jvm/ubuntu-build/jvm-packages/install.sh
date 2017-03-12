#!/bin/bash
export PS4='$ '
echo "Setting up JVM packages"
set -x

apt-get install groovy gradle maven ant scala openjdk-8-jdk openjdk-9-jdk \
  ca-certificates ca-certificates-java
mkdir ~jenkins/java
chown jenkins. ~jenkins/java
ln -s /usr/lib/jvm/java-8-openjdk-amd64 ~jenkins/java/openjdk8
ln -s /usr/lib/jvm/java-9-openjdk-amd64 ~jenkins/java/openjdk9
