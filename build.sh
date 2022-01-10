#!/bin/sh

VER="2.2.3"
[ -e compose ] || {
    curl -o compose.tar.gz https://codeload.github.com/docker/compose/tar.gz/refs/tags/v${VER}
    tar xzf compose.tar.gz
    mv compose-${VER} compose
    rm compose.tar.gz
}

# echo "logging in"
# docker login --username=moltencan

echo "creating builder"
docker buildx create --use

echo "building for dockerhub"
docker buildx build \
    --push \
    --platform "linux/arm/v7,linux/arm/v6,linux/amd64,darwin/arm64" \
    --tag moltencan/docker-compose2:${VER} .

echo "deleting builder"
docker buildx rm
