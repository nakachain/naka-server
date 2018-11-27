#!/bin/sh

docker exec -it naka-server_testnet-node1 /usr/local/bin/geth attach ipc:/root/.naka/geth.ipc
