#!/bin/sh
# Downloads, unzips, and moves bootnode and geth binaries to /usr/local/bin

CURRENT_VERSION=1.5.0

echo "Downloading all geth tools..."
wget "https://github.com/nakachain/go-naka-release/releases/download/v$CURRENT_VERSION/geth-all-linux-amd64-$CURRENT_VERSION.tar.gz"
mkdir /tmp/naka
tar xvzf "geth-all-linux-amd64-$CURRENT_VERSION.tar.gz" -C /tmp/naka/
chmod 755 /tmp/naka/bootnode
chmod 755 /tmp/naka/geth
sudo mv /tmp/naka/bootnode /usr/local/bin
sudo mv /tmp/naka/geth /usr/local/bin
rm "geth-all-linux-amd64-$CURRENT_VERSION.tar.gz"
echo "Finished!"
