#!/bin/sh
# Init script for a new node

DATA_DIR_ROOT=/home/ubuntu/.naka
ERR_MESSAGE="$ ./init.sh /path/to/.env"

# Env file validation
ENV_FILE=$1
if [ -z "$ENV_FILE" ]; then
    echo "env file not given"
    echo $ERR_MESSAGE
    exit 2
fi

# Imports the env file
export $(cat "$ENV_FILE" | xargs)

# Network validation
if [ -z "$NETWORK" ]; then
    echo "network not defined: [mainnet|testnet]"
    exit 2
fi
if [ "$NETWORK" != "mainnet" ] && [ "$NETWORK" != "testnet" ]; then
    echo "invalid network: [mainnet|testnet]"
    exit 2
fi

# Node type validation
if [ -z "$NODE_TYPE" ]; then
    echo "node type not defined: [sealer|client]"
    exit 2
fi
if [ "$NODE_TYPE" != "sealer" ] && [ "$NODE_TYPE" != "client" ]; then
    echo "invalid node type: [sealer|client]"
    exit 2
fi

# Ensure DATA_DIR was set in env
if [ -z "$DATA_DIR" ]; then
    echo "DATA_DIR not found in env file"
    exit 2
fi

# Setup data dir
if [ ! -z "$DATA_DIR" ] && [ ! -d "$DATA_DIR" ]; then
    echo "Setting up data dir..."
    mkdir -p "$DATA_DIR"
fi

# Setup geth logging
if [ "$NETWORK" == "mainnet" ]; then
    LOG_DIR=/var/log/geth/mainnet
else
    LOG_DIR=/var/log/geth/testnet
fi
if [ ! -d "$LOG_DIR" ]; then
    echo "Setting up geth logs..."
    sudo mkdir -p "$LOG_DIR"
    sudo touch "$LOG_DIR/geth.log"
    sudo chown syslog:adm "$LOG_DIR/geth.log"
fi

# Setup bootnode logging
if [ ! -z "$BOOTNODE_KEY" ] && [ ! -f "$LOG_DIR/bootnode.log" ]; then
    echo "Setting up bootnode logs..."
    sudo touch "$LOG_DIR/bootnode.log"
    sudo chown syslog:adm "$LOG_DIR/bootnode.log"
fi

# Create genesis block
if [ ! -d "$DATA_DIR/geth/chaindata" ]; then
    echo "Init genesis block..."
    if [ "$NETWORK" == "mainnet" ]; then
        geth --datadir $DATA_DIR init ../metadata/mainnet/genesis.json
    else
        geth --datadir $DATA_DIR init ../metadata/testnet/genesis.json
    fi
fi

# Imports to the account to the datadir
if [ ! -z "$PW_FILE" ] && [ ! -z "$PK_FILE" ]; then
    echo "Importing account..."
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PK_FILE"
fi

# Copy static-nodes.json to data dir
echo "Copying static-nodes.json..."
if [ "$NETWORK" == "mainnet" ]; then
    cp ../metadata/mainnet/static-nodes.json "$DATA_DIR/geth"
else
    cp ../metadata/testnet/static-nodes.json "$DATA_DIR/geth"
fi

# Route bootnode syslogs to separate log file
if [ ! -z "$BOOTNODE_KEY" ]; then
    if [ "$NETWORK" == "mainnet" ]; then
        echo "Routing bootnode_mainnet logs..."
        sudo cp ../logging/bootnode_mainnet.conf /etc/rsyslog.d
    else
        echo "Routing bootnode_testnet logs..."
        sudo cp ../logging/bootnode_testnet.conf /etc/rsyslog.d
    fi
    sudo systemctl restart rsyslog
fi

# Route geth syslogs to separate log file
if [ "$NETWORK" == "mainnet" ]; then
    echo "Routing geth_mainnet logs..."
    sudo cp ../logging/geth_mainnet.conf /etc/rsyslog.d
else
    echo "Routing geth_testnet logs..."
    sudo cp ../logging/geth_testnet.conf /etc/rsyslog.d
fi
sudo systemctl restart rsyslog

# Add bootnode systemd service
if [ ! -z "$BOOTNODE_KEY" ]; then
    echo "Copying bootnode-nohup.sh to data dir..."
    cp bootnode-nohup.sh $DATA_DIR_ROOT

    if [ "$NETWORK" == "mainnet" ]; then
        echo "Adding bootnode_mainnet.service..."
        sudo cp ../services/bootnode_mainnet.service /etc/systemd/system
        sudo systemctl enable bootnode_mainnet.service
    else
        echo "Adding bootnode_testnet.service..."
        sudo cp ../services/bootnode_testnet.service /etc/systemd/system
        sudo systemctl enable bootnode_testnet.service
    fi
    sudo systemctl daemon-reload
fi

# Add geth systemd service
if [ "$NODE_TYPE" == "sealer" ]; then
    echo "Copying sealer-nohup.sh to $DATA_DIR_ROOT..."
    cp sealer-nohup.sh $DATA_DIR_ROOT

    if [ "$NETWORK" == "mainnet" ]; then
        echo "Adding geth_sealer_mainnet.service..."
        sudo cp ../services/geth_sealer_mainnet.service /etc/systemd/system
        sudo systemctl enable geth_sealer_mainnet.service
    elif [ "$NETWORK" == "testnet" ]; then
        echo "Adding geth_sealer_testnet.service..."
        sudo cp ../services/geth_sealer_testnet.service /etc/systemd/system
        sudo systemctl enable geth_sealer_testnet.service
    fi
elif [ "$NODE_TYPE" == "client" ]; then
    echo "Copying client-nohup.sh to $DATA_DIR_ROOT..."
    cp client-nohup.sh $DATA_DIR_ROOT

    if [ "$NETWORK" == "mainnet" ]; then
        echo "Adding geth_client_mainnet.service..."
        sudo cp ../services/geth_client_mainnet.service /etc/systemd/system
        sudo systemctl enable geth_client_mainnet.service
    elif [ "$NETWORK" == "testnet" ]; then
        echo "Adding geth_client_testnet.service..."
        sudo cp ../services/geth_client_testnet.service /etc/systemd/system
        sudo systemctl enable geth_client_testnet.service
    fi
fi
sudo systemctl daemon-reload

echo "Node initialization finished!"
