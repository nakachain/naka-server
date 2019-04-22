#!/bin/sh
# Initializes a new node
# ./init-account.sh $GENESIS_FILE $PW_FILE $PRIVKEY_FILE $STATICNODE_FILE

DATADIR=$HOME/.naka

# Make dir if needed
mkdir "$DATADIR"

# Create genesis block
geth --datadir "$DATADIR" init $1

# Imports to the account to the datadir
geth --datadir "$DATADIR" account import --password $2 $3

# Copy static-nodes.json to data dir
cp $4 "$DATADIR/geth"
