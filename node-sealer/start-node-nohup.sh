#!/bin/sh

nohup \
geth \
--datadir "$DATA_DIR" \
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
--password "$PW_FILE" \
&
