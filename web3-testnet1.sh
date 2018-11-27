#!/bin/sh

docker exec -it testnet-node1 /usr/local/bin/geth attach ipc:/root/.naka/geth.ipc
