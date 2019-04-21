#!/bin/sh

DIRECTORY="/root/.naka/geth"

if [ ! -d "$DIRECTORY" ]; then
    echo "Datadir not found, exec geth init"
    geth --datadir /root/.naka init /root/.naka/genesis.json
fi
