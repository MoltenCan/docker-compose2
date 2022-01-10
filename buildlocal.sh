#!/bin/sh

docker build -t compose2 .
echo "running compose2 so you can see the syntax"
docker run -it --rm compose2
