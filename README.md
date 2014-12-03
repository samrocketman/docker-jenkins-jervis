# Jervis docker clients

These are the docker build files to create [Jervis][jervis] docker clients as
Jenkins build slaves.

Docker files were written with a combination of
[evarga/jenkins-slave][jenkins-slave] and
[pokle/centos-baseimage][centos-baseimage].

# jervis-docker-jvm

To build the `jervis-docker-jvm` image execute the following commands.

```
cd jervis-docker-jvm
docker build -t jervis-docker-jvm .
```

To view the image interactively run:

```
docker run -i -t jervis-docker-jvm /bin/bash
```

[centos-baseimage]: https://github.com/pokle/centos-baseimage/blob/master/image/Dockerfile
[jenkins-slave]: https://github.com/evarga/docker-images/blob/master/jenkins-slave/Dockerfile
[jervis]: https://github.com/samrocketman/jervis
