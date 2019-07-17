#!/bin/bash

DATA_DIR=/root/.ethereum

# Init genesis block
if [ ! -d "$DATA_DIR/geth/chaindata" ]; then
    echo "Init genesis block..."
    geth init /root/genesis.json
fi
