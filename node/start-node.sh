#!/bin/sh

geth \
--datadir /root/.naka \
--syncmode full \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--rpc \
--rpcaddr 0.0.0.0 \
--rpccorsdomain "*" \
--verbosity 4 \
--mine \
--bootnodes "enode://$BOOTNODE_ID@$BOOTNODE_IP" \
--etherbase "$ADDRESS" \
--unlock "$ADDRESS" \
--password /root/.naka/.accountpw
