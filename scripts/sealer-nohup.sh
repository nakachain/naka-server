#!/bin/sh
# Starts a sealer node independently and sends to the background

nohup \
geth \
--datadir "$DATA_DIR" \
--syncmode full \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--port "$LISTEN_PORT" \
--verbosity 4 \
--mine \
--bootnodes "$BOOTNODES" \
--etherbase "$ACCOUNT_ADDRESS" \
--unlock "$ACCOUNT_ADDRESS" \
--password "$PW_FILE" \
&
