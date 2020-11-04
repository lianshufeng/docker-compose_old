#!/bin/sh
if [[ $(uname -m) == "x86_64" ]];then tag="latest"; else tag=$(uname -m);fi
docker run --name docker-compose --rm -t -i -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) lianshufeng/docker-compose:$tag "$@"