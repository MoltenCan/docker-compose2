#!/bin/sh

dc="/usr/local/bin/docker-compose2"

[ -e /docker-compose.yml ] && {
    cd /
    $dc . $@
    exit $?
}

[ -e /compose/docker-compose.yml ] && {
    cd /compose/
    $dc . $@
    exit $?
}

echo "could not find a compose file"
echo "try this syntax"
echo "docker run -it --rm -v <compose-file>:/docker-compose.yml -v /var/run/docker.sock:/var/run/docker.sock compose2"
echo "docker run -it --rm -v \$(pwd):/compose/ -v /var/run/docker.sock:/var/run/docker.sock compose2"
exit 1
