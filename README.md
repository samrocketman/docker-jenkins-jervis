# Jervis docker clients

These are the docker build files to create [Jervis][jervis] docker clients as
Jenkins build slaves.

# Build all operating system variants

A helpful build script is provided.

    ./build.sh

This will build the following containers:

- `jervis-alpine:latest`
- `jervis-centos7:latest`
- `jervis-centos7-android:latest`
- `jervis-centos7-dnd:latest`
- `jervis-ubuntu1604:latest`
- `jervis-ubuntu1804:latest`

Alternatively, to build a single variant, simply pass one or more directories as
arguments to `build.sh`.  For example, to build `jervis-centos7-android` you
must first build the `jervis-centos7` base image.

    ./build.sh centos7 centos7-android

# Running containers

`docker run` is the typical method for running containers.  To launch the
centos7 container:

    docker run -it --rm jervis-centos7 /bin/bash

Other images can be launched with similar commands unless otherwise stated.

### Working with android emulators

The `jervis-centos7-android` image provides Android SDK tools, Android
platform-tools, and Android emulator.  However, it does not install machine
images or set up hardware.  That's left up to the developer running a build to
do in their build scripts.  Here's an example of starting an emulator in the
background for running UI tests.  For operating on most common Android phones,
`android-22` for ARMv7 is recommended.

    docker run -it --rm jervis-centos7-android /bin/bash

From within the docker container:

    yes | sdkmanager platform-tools emulator 'platforms;android-22' 'system-images;android-22;default;armeabi-v7a'
    yes '' | avdmanager create avd --package 'system-images;android-22;default;armeabi-v7a' --abi armeabi-v7a --name android-phone
    adb start-server
    nohup emulator -avd android-phone -no-skin -no-window &

Now you're ready to run your tests.

    ./gradlew clean test connectedAndroidTest

### Working with docker in docker

The `jervis-centos7-dnd` image is provided for docker in docker operations.
Running the container with `--privileged` is required, however Docker CE has
done a lot of work to make sure `--privileged` is as safe as possible to run
docker in docker.  The reason why `--privileged` is required is that docker
needs write access to `/sys/fs/cgroup` and other kernel APIs only available in
`--privileged` mode.

See security writeups:

- [Docker security][docker-security].
- [Docker run capabilies when `--privileged` option is
  used][docker-capabilities].

Starting a docker container which runs docker in docker.

    docker volume create docker-data
    docker run -it --rm --privileged -v docker-data:/var/lib/docker jervis-centos7-dnd /bin/bash

All following commands occur within the docker container.

```bash
# start docker daemon with debug logging
sudo -i nohup dockerd -D &
# writes docker daemon logs to /root/nohup.out
docker pull centos:7
# run a docker container inside of the docker container
docker run -it --rm centos:7 /bin/bash
```

Things to note:

- docker daemon requires write access to a volume mounted on `/var/lib/docker`.
  We did that by using docker volumes with `-v docker-data:/var/lib/docker`.
- **Do not** use the `docker-data` volume with more than one docker in docker
  container.  If you need to launch a second docker in docker container, then
  create and mount a volume with a different name.  Accessing `/var/lib/docker`
  with multiple docker daemons will cause data corruption.

[docker-capabilities]: https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities
[docker-security]: https://docs.docker.com/engine/security/security/
[jervis]: https://github.com/samrocketman/jervis
