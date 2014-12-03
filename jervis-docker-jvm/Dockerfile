FROM phusion/baseimage
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>

#phusion baseimage recommendations
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
# Standard SSH port
EXPOSE 22
#default command
CMD ["/sbin/my_init"]

#Jervis Jenkins agent
RUN mkdir /build
ADD ubuntu-build /build

#apt should always use -y --no-install-recommends
RUN /build/apt/install.sh

#sudo with no password
RUN /build/sudoers/install.sh

#install the SSH server
RUN /build/sshd/install.sh

#install jvm packages
#RUN /build/jvm-packages/install.sh

#jenkins user info
RUN /build/jenkins/install.sh

#some final clean up
RUN /build/clean.sh
