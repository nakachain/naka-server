#!/bin/sh

CURRENT_VERSION=v1.5.0

# Install unzip
echo "Installing unzip"
sudo apt-get install unzip

# Fetch and unzip bootnode
echo "Downloading bootnode"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/bootnode.zip"
echo "Unzipping bootnode"
unzip bootnode.zip
chmod 755 bootnode
sudo mv bootnode /usr/local/bin
rm bootnode.zip

# Fetch and unzip geth
echo "Downloading geth"
wget "https://github.com/nakachain/go-naka-release/releases/download/$CURRENT_VERSION/geth-linux-amd64"
mv geth-linux-amd64 geth
chmod 755 geth
sudo mv geth /usr/local/bin
rm geth.zip
