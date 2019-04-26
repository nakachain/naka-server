#!/bin/sh
# Initializes a new node
# Inject env args before calling script

# Make data dir if needed
if [ ! -z "$DATA_DIR" ] && [ ! -d "$DATA_DIR" ]; then
    echo "Creating data dir"
    mkdir -p "$DATA_DIR"
fi

# Make logs dir if needed
if [ ! -z "$LOG_DIR" ] && [ ! -d "$LOG_DIR" ]; then
    echo "Creating log dir"
    mkdir -p "$LOG_DIR"
fi

# Create genesis block
if [ ! -z "$DATA_DIR" ] && [ ! -z "$GENESIS_FILE" ]; then
    echo "Init genesis block"
    geth --datadir "$DATA_DIR" init "$GENESIS_FILE"
fi

# Imports to the account to the datadir
if [ ! -z "$DATA_DIR" ] && [ ! -z "$PW_FILE" ] && [ ! -z "$PRIV_KEY_FILE" ]; then
    echo "Importing account"
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"
fi

# Copy static-nodes.json to data dir
if [ ! -z "$STATIC_NODE_FILE" ] && [ ! -z "$DATA_DIR" ]; then
    echo "Copying static-node.json"
    cp "$STATIC_NODE_FILE" "$DATA_DIR/geth"
fi
