#!/bin/sh

docker exec -it testnet-client /usr/local/bin/geth attach ipc:/root/.naka/geth.ipc
