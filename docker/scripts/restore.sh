#!/bin/sh

MESSAGE="$ ./restore.sh docker-volume-name /path/to/backup/dir"
VOLUME_NAME=$1
ORIGIN_PATH=$2

if [ -z "${VOLUME_NAME}" ]
then
    echo "volume name not defined"
    echo ${MESSAGE}
    exit 2
fi

if [ -z "${ORIGIN_PATH}" ]
then
    echo "backup dir not defined"
    echo ${MESSAGE}
    exit 2
fi

echo "Restoring volume ${VOLUME_NAME}"
echo "Writing from ${ORIGIN_PATH}"

# Get mountpoint path
docker volume inspect ${VOLUME_NAME} > volume.txt
MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
rm volume.txt

# Copy chaindata folders
sudo cp -r ${ORIGIN_PATH} "${MOUNTPOINT}/geth/chaindata" 
sudo cp -r ${ORIGIN_PATH} "${MOUNTPOINT}/geth/lightchaindata"

echo "Finished restoring volume ${VOLUME_NAME}"
