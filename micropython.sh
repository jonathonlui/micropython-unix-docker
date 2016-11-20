#!/bin/sh

docker run -it --rm -v $PWD:/usr/src/app jonathonlui/micropython "$@"
