# Jervis docker clients

These are the docker build files to create [Jervis][jervis] docker clients as
Jenkins build slaves.

Docker files were written with a combination of
[evarga/jenkins-slave][jenkins-slave],
[pokle/centos-baseimage][centos-baseimage], and [phusion/baseimage][phusion].

# Ubuntu jervis-docker-jvm

To build the `jervis-docker-jvm` image execute the following commands.

```
cd jervis-docker-jvm
docker build -t jervis-docker-jvm .
```

To view the image interactively you must connect to the container over SSH.
First you must get the private key.

```
curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
chmod 600 insecure_key
```

Then start the container.

```
docker create jervis-docker-jvm | xargs docker start | xargs docker inspect -f "{{ .NetworkSettings.IPAddress }}"
```

The value returned from starting the container is the IP address.  Use that IP
to connect over SSH.

```
ssh -i insecure_key jenkins@<ip address>
```

[centos-baseimage]: https://github.com/pokle/centos-baseimage/blob/master/image/Dockerfile
[jenkins-slave]: https://github.com/evarga/docker-images/blob/master/jenkins-slave/Dockerfile
[jervis]: https://github.com/samrocketman/jervis
[phusion]: https://github.com/phusion/baseimage-docker
