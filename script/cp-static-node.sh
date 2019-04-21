# Copy static-node.json to Docker volume
#!/bin/sh

# Get mountpoint path
get_mountpoint () {
    docker volume inspect $1 > volume.txt
    MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
    rm volume.txt
}

MESSAGE="$ ./cp-static-node.sh [mainnet/testnet] [sealer/client]"
MAINNET_SEALER_VOL_NAME="mainnet_mainnet-sealer-data"
MAINNET_CLIENT_VOL_NAME="mainnet_mainnet-client-data"
TESTNET_SEALER_VOL_NAME="testnet_testnet-sealer-data"
TESTNET_CLIENT_VOL_NAME="testnet_testnet-client-data"

echo "Copying static-node.json"

# Validate network
if [ $1 = "mainnet" ] && [ $2 = "sealer" ] then
    get_mountpoint $MAINNET_SEALER_VOL_NAME
    sudo cp -r ./mainnet/static-nodes.json $MOUNTPOINT
elif [ $1 = "mainnet" ] && [ $2 = "client" ] then
    get_mountpoint $MAINNET_CLIENT_VOL_NAME
    sudo cp -r ./mainnet/static-nodes.json $MOUNTPOINT
elif [ $1 = "testnet" ] && [ $2 = "sealer" ] then
    get_mountpoint $TESTNET_SEALER_VOL_NAME
    sudo cp -r ./testnet/static-nodes.json $MOUNTPOINT
elif [ $1 = "testnet" ] && [ $2 = "client" ] then
    get_mountpoint $TESTNET_CLIENT_VOL_NAME
    sudo cp -r ./testnet/static-nodes.json $MOUNTPOINT
else
    echo "invalid network or node type"
    echo ${MESSAGE}
    exit 2
fi

echo "Success"
