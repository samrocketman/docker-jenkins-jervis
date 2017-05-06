FROM ubuntu:16.04
MAINTAINER Sam Gleske <sam.mxracer@gmail.com>


#Jervis Jenkins agent
RUN mkdir /build
ADD ubuntu-build /build

#apt should always use -y --no-install-recommends
RUN /build/apt/install.sh

#sudo with no password
RUN /build/sudoers/install.sh

#jenkins user info
RUN /build/jenkins/install.sh

#set up Java language support
RUN /build/jvm-packages/install.sh

#set up Ruby language support
RUN /build/rvm-packages/install.sh

#set up Go support
RUN curl -sL -o /usr/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme && chmod 755 /usr/bin/gimme

#FINAL IMAGE PREPARATION

#install a container init process
RUN curl -Lo /bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod 755 /bin/dumb-init
ENTRYPOINT ["/bin/dumb-init", "--"]
USER 'jenkins'
WORKDIR /home/jenkins
