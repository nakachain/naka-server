#!/bin/sh
# Updates static-nodes.json for an already init'ed node

MAINNET_DEST=$HOME/.naka/mainnet/geth/static-nodes.json
TESTNET_DEST=$HOME/.naka/testnet/geth/static-nodes.json

echo "Update static-nodes.json"
echo "========================"
echo "Enter input:"
echo "1 for Mainnet"
echo "2 for Testnet"

read NETWORK
if [ "$NETWORK" = "1" ]; then
    if [ ! -f $MAINNET_DEST ]; then
        echo "$MAINNET_DEST does not exist, did you forget to init?"
        exit 2
    fi

    echo "Copying mainnet static-nodes.json to $MAINNET_DEST"
    cp ../metadata/mainnet/static-nodes.json $MAINNET_DEST
elif [ "$NETWORK" = "2" ]; then
    if [ ! -f $TESTNET_DEST ]; then
        echo "$TESTNET_DEST does not exist, did you forget to init?"
        exit 2
    fi

    echo "Copying testnet static-nodes.json to $TESTNET_DEST"
    cp ../metadata/testnet/static-nodes.json $TESTNET_DEST
else
    echo "Invalid network!"
fi
