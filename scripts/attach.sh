#!/bin/sh
# Attaches geth console to instance

MAINNET_IPC=$HOME/.naka/mainnet/geth.ipc
TESTNET_IPC=$HOME/.naka/testnet/geth.ipc

echo "Attaching geth"
echo "=============="
echo "Enter input:"
echo "1 for Mainnet"
echo "2 for Testnet"

read NETWORK
if [ "$NETWORK" = "1" ]; then
    geth attach ipc:$MAINNET_IPC
elif [ "$NETWORK" = "2" ]; then
    geth attach ipc:$TESTNET_IPC
else
    echo "Invalid network!"
fi
