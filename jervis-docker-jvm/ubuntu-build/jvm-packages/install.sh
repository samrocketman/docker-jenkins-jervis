#!/bin/bash
export PS4='$ '
echo "Setting up JVM packages"
set -x

apt-get install groovy gradle maven ant scala openjdk-7-jdk openjdk-6-jdk
mkdir ~jenkins/java
chown jenkins. ~jenkins/java
ln -s /usr/lib/jvm/java-6-openjdk-amd64 ~jenkins/java/openjdk6
ln -s /usr/lib/jvm/java-7-openjdk-amd64 ~jenkins/java/openjdk7
