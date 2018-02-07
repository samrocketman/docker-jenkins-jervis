# Jervis docker clients

These are the docker build files to create [Jervis][jervis] docker clients as
Jenkins build slaves.

# Ubuntu 16.04 container

To build the `jervis-ubuntu` image execute the following commands.

```
cd ubuntu1604/
docker build -t jervis-ubuntu .
```

# Alpine Linux container

To build the `jervis-alpine` image execute the following commands.

```
cd alpine/
docker build -t jervis-alpine .
```

[jervis]: https://github.com/samrocketman/jervis
