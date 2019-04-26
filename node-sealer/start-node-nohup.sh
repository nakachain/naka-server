#!/bin/sh

LOGS_DIR=$HOME/.naka/logs

# Create logs dir
mkdir -p "$LOGS_DIR"

# Start geth
nohup \
geth \
--datadir "$HOME/.naka" \
--syncmode full \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--rpc \
--rpcaddr "127.0.0.1" \
--rpccorsdomain "127.0.0.1" \
--verbosity 4 \
--mine \
--bootnodes "$BOOTNODES" \
--etherbase "$ACCOUNT_ADDRESS" \
--unlock "$ACCOUNT_ADDRESS" \
--password "$ACCOUNT_PW_PATH" \
>> "$LOGS_DIR/geth.log" &