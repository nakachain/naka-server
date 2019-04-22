#!/bin/sh

CURRENT_VERSION=v1.5.0

# Install unzip
sudo apt-get install unzip

# Fetch and unzip bootnode
echo "Downloading bootnode"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/bootnode.zip"
echo "Unzipping bootnode"
sudo unzip bootnode.zip /usr/local/bin
sudo chmod 755 /usr/local/bin/bootnode
rm bootnode.zip

# Fetch and unzip geth
echo "Downloading geth"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/geth.zip"
echo "Unzipping geth"
sudo unzip geth.zip /usr/local/bin
sudo chmod 755 /usr/local/bin/geth
rm geth.zip
