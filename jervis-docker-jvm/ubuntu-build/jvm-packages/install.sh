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
for x in 8u141-oracle; do
  yes | sdk install java "${x}"
  ln -s "${HOME}/.sdkman/candidates/java/${x}" "${HOME}/java/openjdk${x:0:1}"
done
yes | sdk default java 8u141-oracle
