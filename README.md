# How to build image in diff machine and send in one manifest:

in Dockerfile add ARCH arg

```
ARG ARCH=
FROM ${ARCH}/debian:bullseye-slim
```

Start build:
```
docker build -t ghcr.io/userver-framework/docker-userver-build-base:manifest-arm64v8 \
    --build-arg ARCH=arm64v8 --platform linux/arm64 .
    
docker build -t ghcr.io/userver-framework/docker-userver-build-base:manifest-arm32v7 \
    --build-arg ARCH=arm32v7 --platform linux/arm/v7 .
    
docker build -t ghcr.io/userver-framework/docker-userver-build-base:manifest-amd64 \
    --build-arg ARCH=amd64 --platform linux/amd64 .
```

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
