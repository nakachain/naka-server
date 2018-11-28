#!/bin/sh

geth --datadir /root/.naka --syncmode full --networkid 25 --nat=none --targetgaslimit 4700000 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --ws --wsaddr 0.0.0.0 --verbosity 4 --bootnodes "enode://$BOOTNODE_ID@$BOOTNODE_IP:30301"
