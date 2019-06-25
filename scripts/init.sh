#!/bin/sh
# Initializes a new node

ERR_MESSAGE="$ ./init.sh /path/to/.env [mainnet|testnet] [sealer|client]"

# Env path validation
ENV_FILE=$1
if [ -z "$ENV_FILE" ]; then
    echo "env file not given"
    echo $ERR_MESSAGE
    exit 2
fi

# Network validation
NETWORK=$2
if [ -z "$NETWORK" ]; then
    echo "network not given"
    echo $ERR_MESSAGE
    exit 2
fi
if [ "$NETWORK" != "mainnet" ] && [ "$NETWORK" != "testnet" ]; then
    echo "invalid network"
    echo $ERR_MESSAGE
    exit 2
fi

# Node type validation
NODE_TYPE=$3
if [ -z "$NODE_TYPE" ]; then
    echo "node type not given"
    echo $ERR_MESSAGE
    exit 2
fi
if [ "$NODE_TYPE" != "sealer" ] && [ "$NODE_TYPE" != "client" ]; then
    echo "invalid node type"
    echo $ERR_MESSAGE
    exit 2
fi

# Imports the env file
export $(cat "$ENV_FILE" | xargs)

# Setup data dir
if [ ! -z "$DATA_DIR" ] && [ ! -d "$DATA_DIR" ]; then
    echo "Setting up data dir..."
    mkdir -p "$DATA_DIR"
fi

# Setup logging
if [ ! -z "$LOG_DIR" ] && [ ! -d "$LOG_DIR" ]; then
    echo "Setting up geth logs..."
    sudo mkdir -p "$LOG_DIR"
    sudo touch "$LOG_DIR/geth.log"
    sudo chown syslog:adm "$LOG_DIR/geth.log"

    # Setup bootnode logs if needed
    if [ ! -z "$BOOTNODE_KEY" ]; then
        echo "Setting up bootnode logs..."
        sudo touch "$LOG_DIR/bootnode.log"
        sudo chown syslog:adm "$LOG_DIR/bootnode.log"
    fi
fi

# Create genesis block
if [ ! -z "$DATA_DIR" ] && [ ! -z "$GENESIS_FILE" ] && [ ! -d "$DATA_DIR/geth/chaindata" ]; then
    echo "Init genesis block..."
    geth --datadir $DATA_DIR init $GENESIS_FILE
fi

# Imports to the account to the datadir
if [ ! -z "$DATA_DIR" ] && [ ! -z "$PW_FILE" ] && [ ! -z "$PK_FILE" ]; then
    echo "Importing account..."
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PK_FILE"
fi

# Copy static-nodes.json to data dir
if [ ! -z "$DATA_DIR" ]; then
    echo "Copying static-node.json..."
    if [ "$NETWORK" == "mainnet" ]; then
        cp ../metadata/mainnet/static-nodes.json "$DATA_DIR/geth"
    else
        cp ../metadata/testnet/static-nodes.json "$DATA_DIR/geth"
    fi
fi

# Create bootnode systemd service
if [ ! -z "$BOOTNODE_SERVICE" ]; then
    echo "Creating bootnode service..."
    sudo cp "$BOOTNODE_SERVICE" /etc/systemd/system
    sudo systemctl enable bootnode.service
    sudo systemctl daemon-reload
fi

# Create geth systemd service
if [ ! -f "/etc/systemd/system/geth.service" ]; then
    echo "Creating geth service..."
    sudo cp "$SERVICE_FILE" /etc/systemd/system
    sudo systemctl enable geth.service
    sudo systemctl daemon-reload
fi

# Route geth syslogs to separate log file
if [ ! -z "$GETH_LOG_CONFIG" ]; then
    echo "Routing geth logs..."
    sudo cp "$GETH_LOG_CONFIG" /etc/rsyslog.d
    sudo systemctl restart rsyslog
fi

# Route bootnode syslogs to separate log file
if [ ! -z "$BOOTNODE_LOG_CONFIG" ]; then
    echo "Routing bootnode logs..."
    sudo cp "$BOOTNODE_LOG_CONFIG" /etc/rsyslog.d
    sudo systemctl restart rsyslog
fi

# Setup log rotation
if [ $(cat /etc/logrotate.conf | grep -c "/var/log/geth/geth.log") -eq 0 ]; then
    echo "Setting up log rotation..."
    echo "\n/var/log/geth/geth.log {\n    missingok\n    daily\n    create 0644 syslog adm\n    size 100M\n    copytruncate\n    maxage 14\n    rotate 9\n}" | sudo tee -a /etc/logrotate.conf
fi

echo "Node init finished!"
