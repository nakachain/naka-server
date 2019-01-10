#!/bin/sh

MESSAGE="$ ./backup.sh docker-volume-name /path/to/backup/dir"
VOLUME_NAME=$1
DEST_PATH=$2

if [ -z "${VOLUME_NAME}" ]
then
    echo "volume name not defined"
    echo ${MESSAGE}
    exit 2
fi

if [ -z "${DEST_PATH}" ]
then
    echo "destination not defined"
    echo ${MESSAGE}
    exit 2
fi

echo "Backing up volume ${VOLUME_NAME}"
echo "Writing to ${DEST_PATH}"

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
