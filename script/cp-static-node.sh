# Copy static-node.json to Docker volume
#!/bin/sh

MESSAGE="$ ./cp-static-node.sh [mainnet/testnet] [sealer/client]"
MAINNET_SEALER_VOL_NAME="sealer_mainnet-sealer-data"
MAINNET_CLIENT_VOL_NAME="client_mainnet-client-data"
TESTNET_SEALER_VOL_NAME="sealer_testnet-sealer-data"
TESTNET_CLIENT_VOL_NAME="client_testnet-client-data"

display_error_msg () {
    echo "invalid network or node type"
    echo ${MESSAGE}
    exit 2
}

# Get mountpoint path
get_mountpoint () {
    docker volume inspect $1 > volume.txt
    MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
    rm volume.txt
}

# Validate network
if [ "$1" = "mainnet" ]; then
    if [ "$2" = "sealer" ]; then
        echo "Copying static-node.json to mainnet sealer"
        get_mountpoint $MAINNET_SEALER_VOL_NAME
        sudo cp -r ../mainnet/static-nodes.json $MOUNTPOINT
    elif [ "$2" = "client" ]; then
        echo "Copying static-node.json to mainnet client"
        get_mountpoint $MAINNET_CLIENT_VOL_NAME
        sudo cp -r ../mainnet/static-nodes.json $MOUNTPOINT
    else
        display_error_msg
    fi
elif [ "$1" = "testnet" ]; then
    if [ "$2" = "sealer" ]; then
        echo "Copying static-node.json to testnet sealer"
        get_mountpoint $TESTNET_SEALER_VOL_NAME
        sudo cp -r ../testnet/static-nodes.json $MOUNTPOINT
    elif [ "$2" = "client" ]; then
        echo "Copying static-node.json to testnet client"
        get_mountpoint $TESTNET_CLIENT_VOL_NAME
        sudo cp -r ../testnet/static-nodes.json $MOUNTPOINT
    else
        display_error_msg
    fi
else
    display_error_msg
fi

echo "Success"
