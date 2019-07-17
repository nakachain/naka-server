#!/bin/sh
# start-client.sh
# Init and start a client node

DATA_DIR=/root/.ethereum

# Init genesis block and data dir
if [ ! -d "$DATA_DIR/geth/chaindata" ]; then
    echo "Init genesis block..."
    geth init /root/genesis.json
fi

# Copy static-nodes.json
echo "Copying static-nodes.json"
cp /root/static-nodes.json "$DATA_DIR/geth"

echo "Node initialization finished!"

# Run geth
geth \
--syncmode full \
--gcmode archive \
--networkid "${CHAIN_ID}" \
--nat=none \
--targetgaslimit 4700000 \
--port "${LISTEN_PORT}" \
--rpc \
--rpcaddr 0.0.0.0 \
--rpcport "${RPC_PORT}" \
--rpccorsdomain "*" \
--rpcapi db,debug,eth,net,web3 \
--ws \
--wsaddr 0.0.0.0 \
--wsport "${WS_PORT}" \
--wsorigins "*" \
--wsapi db,debug,eth,net,web3 \
--verbosity 4 \
--bootnodes "${BOOTNODES}"
