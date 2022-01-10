#!/bin/sh

VER="2.2.3"
[ -e compose ] || {
    curl -o compose.tar.gz https://codeload.github.com/docker/compose/tar.gz/refs/tags/v${VER}
    tar xzf compose.tar.gz
    mv compose-${VER} compose
    rm compose.tar.gz
}

cd compose
go mod tidy && go mod vendor
cd ..

# echo "logging in"
# docker login --username=moltencan

echo "creating builder"
docker buildx create --use

echo "building for dockerhub"
docker buildx build \
    --push \
    --platform "linux/arm/v7,linux/arm/v6,linux/amd64,linux/arm64/v8" \
    --tag moltencan/docker-compose2:${VER} \
    --tag moltencan/docker-compose2:latest \
    .

echo "deleting builder"
docker buildx rm
