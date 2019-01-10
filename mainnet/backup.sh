#!/bin/sh

VOLUME_NAME="mainnet_mainnet-client-data"
DEST_PATH="/root/.naka/mainnet/geth"

echo "Copying volume ${VOLUME_NAME}..."

# Get mountpoint path
docker volume inspect ${VOLUME_NAME} > volume.txt
MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
rm volume.txt

# Make dirs if needed
sudo mkdir -p "${DEST_PATH}/chaindata"
sudo mkdir -p "${DEST_PATH}/lightchaindata"

# Cleanup old files
sudo rm -rf "${DEST_PATH}/chaindata"
sudo rm -rf "${DEST_PATH}/lightchaindata"

# Copy chaindata folders
sudo cp -r "${MOUNTPOINT}/geth/chaindata" ${DEST_PATH}
sudo cp -r "${MOUNTPOINT}/geth/lightchaindata" ${DEST_PATH}
