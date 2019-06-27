#!/bin/sh
# Starts a client node independently and sends to the background

nohup \
geth \
--datadir "$DATA_DIR" \
--syncmode full \
--gcmode archive \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--port "$LISTEN_PORT" \
--rpc \
--rpcaddr 0.0.0.0 \
--rpcport "$RPC_PORT" \
--rpccorsdomain "*" \
--rpcapi db,debug,eth,net,web3 \
--ws \
--wsaddr 0.0.0.0 \
--wsport "$WS_PORT" \
--wsorigins "*" \
--wsapi db,debug,eth,net,web3 \
--verbosity 4 \
--bootnodes "$BOOTNODES" \
&
