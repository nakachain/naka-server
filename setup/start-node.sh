#!/bin/sh

geth --datadir /root/.naka --syncmode full --networkid 25 --nat=none --targetgaslimit 4700000 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --verbosity 4 --mine --bootnodes "enode://$BOOTNODE_ID@$BOOTNODE_IP:30301" --etherbase "$ADDRESS" --unlock "$ADDRESS" --password /root/.naka/.accountpw