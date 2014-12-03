FROM ubuntu:14.04
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

RUN mkdir /build

#apt should always use -y
ADD ubuntu-build/apt /build/apt
RUN /build/apt/install.sh

#sudo with no password
ADD ubuntu-build/sudoers /build/sudoers
RUN /build/sudoers/install.sh

#install the SSH server
ADD ubuntu-build/sshd /build/sshd
RUN /build/sshd/install.sh

#jenkins user info
ADD ubuntu-build/jenkins /build/jenkins
RUN /build/jenkins/install.sh

#some final clean up
RUN rm -rf /build
RUN apt-get clean

# Standard SSH port
EXPOSE 22

#default command
CMD ["/usr/sbin/sshd", "-D"]
