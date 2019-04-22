#!/bin/sh

docker exec -it $1 /usr/local/bin/geth attach ipc:/root/.naka/geth.ipc
