#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- docker-compose "$@"
fi

# if our command is a valid Docker subcommand, let's invoke it through Docker instead
# (this allows for "docker run docker ps", etc)
if docker-compose help "$1" > /dev/null 2>&1; then
	set -- docker-compose "$@"
fi


exec "$@"