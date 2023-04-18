# How to build image in diff machine and send in one manifest:

Follow the [instructions](https://userver.tech/d5/d1b/md_en_userver_docker.html)

Push images:

```
docker push ghcr.io/userver-framework/docker-userver-build-base:manifest-arm64v8

docker push ghcr.io/userver-framework/docker-userver-build-base:manifest-arm32v7

docker push ghcr.io/userver-framework/docker-userver-build-base:manifest-amd64
```

Create manifest
```
docker manifest create ghcr.io/userver-framework/docker-userver-build-base:v1 \
    ghcr.io/userver-framework/docker-userver-build-base:manifest-arm32v7 \
    ghcr.io/userver-framework/docker-userver-build-base:manifest-arm64v8 \
    ghcr.io/userver-framework/docker-userver-build-base:v1-amd64
```

Push manifest:

```
docker manifest push ghcr.io/userver-framework/docker-userver-build-base:v1
```

**Done**
