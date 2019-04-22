#!/bin/sh

CURRENT_VERSION=v1.5.0

echo "Downloading bootnode"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/bootnode.zip"
echo "Unzipping bootnode"
unzip bootnode.zip /usr/local/bin
sudo chmod 755 /usr/local/bin/bootnode

echo "Downloading geth"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/geth.zip"
echo "Unzipping geth"
unzip geth.zip /usr/local/bin
sudo chmod 755 /usr/local/bin/geth
