#!/bin/sh

DIRECTORY="/root/.naka/geth"

if [ ! -d "$DIRECTORY" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    geth --datadir /root/.naka init /root/.naka/genesis.json
fi
