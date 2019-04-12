
# Running SourceClear via Docker

## Why?

The SourceClear agent is [natively packaged](https://www.sourceclear.com/docs/command-line-interface/) for most platforms but isn't supported on some, e.g. the musl-based Alpine. This provides a way to run it on any platform with Docker support.

## Getting started

Build an image containing the agent:

```sh
docker build . -t srcclr/agent
```

[Perform a scan](https://www.sourceclear.com/docs/agent-usage/):

```sh
export SRCCLR_API_TOKEN=token
./srcclr scan --url https://github.com/srcclr/example-ruby --quick
```

This scans the given repository within a container and cleans everything up when done.

## Building your projects

For accurate results, the agent scans projects by building them and observing the dependencies resolved by their package managers. Full scans therefore require build-time dependencies, such as external programs and system libraries, to be present in the container.

An easy way to accomplish this is to extend the image built earlier with a second Dockerfile:

```Dockerfile
FROM srcclr/agent
RUN apt-get update -y && apt-get install -y maven
```

```sh
docker build . -f Dockerfile-maven -t srcclr/agent-maven
```

With that done, full scans will work.

```sh
IMAGE=srcclr/agent-maven ./srcclr scan --url https://github.com/srcclr/example-java-maven
```

To speed up builds, it may be useful to mount system-wide cache directories. This may be done using `$DOCKER_ARGS`:

```sh
DOCKER_ARGS="-v $HOME/.m2:/root/.m2" IMAGE=srcclr/agent-maven \
  ./srcclr scan --url https://github.com/srcclr/example-java-maven
```

The `srcclr` [script](/srcclr) predefines a few build `$TYPE`s to simplify this configuration, so all of the above may be done with:

```sh
TYPE=maven ./srcclr scan --url https://github.com/srcclr/example-java-maven
```
