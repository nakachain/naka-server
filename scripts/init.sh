#!/bin/sh
# Initializes a new node

ERR_MESSAGE="$ ./init.sh /path/to/.env [mainnet|testnet] [sealer|client]"

# Reads the cli args
ENV_FILE=$1
if [ -z "$ENV_FILE" ]; then
    echo "env file not given"
    echo $ERR_MESSAGE
    exit 2
fi
NETWORK=$2
if [ -z "$NETWORK" ]; then
    echo "network not given"
    echo $ERR_MESSAGE
    exit 2
fi
NODE_TYPE=$3
if [ -z "$NETWORK" ]; then
    echo "node type not given"
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
if [ ! -z "$DATA_DIR" ] && [ ! -z "$PW_FILE" ] && [ ! -z "$PRIV_KEY_FILE" ]; then
    echo "Importing account..."
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"
fi

# Copy static-nodes.json to data dir
if [ ! -z "$STATIC_NODE_FILE" ] && [ ! -z "$DATA_DIR" ]; then
    echo "Copying static-node.json..."
    cp "$STATIC_NODE_FILE" "$DATA_DIR/geth"
fi

# Create geth systemd service
if [ ! -f "/etc/systemd/system/geth.service" ]; then
    echo "Creating geth service..."
    sudo cp "$SERVICE_FILE" /etc/systemd/system
    sudo systemctl enable geth.service
    sudo systemctl daemon-reload
fi

# Route geth syslogs to separate log file
if [ ! -f "/etc/rsyslog.d/geth.conf" ]; then
    echo "Routing geth logs..."
    sudo cp "$SYSLOG_CONF_FILE" /etc/rsyslog.d
    sudo systemctl restart rsyslog
fi

# Setup log rotation
if [ $(cat /etc/logrotate.conf | grep -c "/var/log/geth/geth.log") -eq 0 ]; then
    echo "Setting up log rotation..."
    echo "\n/var/log/geth/geth.log {\n    missingok\n    daily\n    create 0644 syslog adm\n    size 100M\n    copytruncate\n    maxage 14\n    rotate 9\n}" | sudo tee -a /etc/logrotate.conf
fi

echo "Node init finished!"