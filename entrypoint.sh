#!/bin/sh

function print_help {
    echo "try this syntax"
    echo "docker run -it --rm -v <compose-file>:/docker-compose.yml -v /var/run/docker.sock:/var/run/docker.sock moltencan/docker-compose2 up -d"
    echo "docker run -it --rm -v \$(pwd):/compose/ -v /var/run/docker.sock:/var/run/docker.sock moltencan/docker-compose2 up -d"
}

[ "$1" == "help" ] && {
    print_help
    exit 1
}

[ -z $1 ] && {
    echo "you did not specify a compose action"
    print_help
    exit 1
}

[ -e /var/run/docker.sock ] || {
    echo "/var/run/docker.sock not there, maybe add"
    echo "-v /var/run/docker.sock:/var/run/docker.sock"
    print_help
    exit 1
}

dc="/usr/local/bin/docker-compose2"
[ -e /docker-compose.yml ] && {
    cd /
    $dc $@
    exit $?
}

[ -e /compose/docker-compose.yml ] && {
    cd /compose/
    $dc $@
    exit $?
}

echo "could not find a compose file"
print_help
exit 1
