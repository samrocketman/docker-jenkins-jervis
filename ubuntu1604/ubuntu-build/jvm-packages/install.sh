#!/bin/bash
export PS4='$ '
echo "Setting up JVM packages"
set -e

if [ ! "${USER}" = "jenkins" ]; then
  su - jenkins -c "$0" "$@"
  exit $?
fi

bash < /build/jvm-packages/get.sdkman.io
source "${HOME}/.sdkman/bin/sdkman-init.sh"

yes | sdk install maven 3.3.9
yes | sdk install groovy 2.4.11
yes | sdk install gradle 3.5

#install the versions of Java used by Jervis
mkdir ~jenkins/java
java=8.0.161-oracle
yes | sdk install java "${java}"
ln -s "${HOME}/.sdkman/candidates/java/${java}" "${HOME}/java/openjdk${java:0:1}"
yes | sdk default java "${java}"
