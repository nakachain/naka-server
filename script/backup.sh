#!/bin/sh

VOLUME_NAME=$1
DEST_PATH=$2

if [ -z "${VOLUME_NAME}" ]
then
    echo "volume name not defined"
    exit 2
else
    echo "Backing up volume ${VOLUME_NAME}"
fi

if [ -z "${DEST_PATH}" ]
then
    echo "destination not defined"
    exit 2
else
    echo "Writing to ${DEST_PATH}"
fi

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

echo "Finished backing up volume ${VOLUME_NAME}"
