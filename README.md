# Naka Server

This repo contains all the necessary config and scripts to run [go-naka](https://github.com/nakachain/go-naka) nodes.

## Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM

## New Node Setup

1. Clone repo
2. `cd naka-server/script`
3. Download the required binaries by running `./download-bin.sh`
4. Create the data directory at `/home/ubuntu/.naka`. Please note that it needs to be this directory or you will have to [change some other things](#changing-data-dir).
5. Create env file. See [Environment Setup](#environment-setup).
6. Run init script and pass in your newly-created .env file: `./init.sh /home/ubuntu/.naka/mainnet/.env`
7. [Setup log rotations](#setup-automatic-log-rotation)
8. Use the [system command](#start-node) to start the node

**Note: all system services automatically auto-run on reboots.**

## Environment Setup

- [Chain ID](https://docs.nakachain.org/docs/nakachain-metadata/#chain-id)
- [Bootnodes](https://docs.nakachain.org/docs/nakachain-metadata/#bootnodes)
- Default .env locations: mainnet = `/home/ubuntu/.naka/mainnet/.env`, testnet = `/home/ubuntu/.naka/testnet/.env`

### Client Env

See `example-client.env` for an example. You will need to create an `.env` file in the default `DATA_DIR` location. Below is the explanation for each field.

```bash
# Network type: mainnet|testnet
NETWORK=mainnet

# Node type: client|sealer
NODE_TYPE=client

# Chain ID for the chain
CHAIN_ID=2019

# Data directory where all geth data will go
DATA_DIR=/home/ubuntu/.naka/mainnet

# Port where the node will listen for other nodes trying to connect
LISTEN_PORT=30303

# Port for HTTP-RPC server
RPC_PORT=8545

# Port for WS-RPC server
WS_PORT=8546

# Comma-separated values for all the bootnodes
BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301

# Bootnode key if you are running a bootnode on this server (optional)
BOOTNODE_KEY=
```

### Sealer Env

See `example-sealer.env` for an example. You will need to create an `.env` file in the default `DATA_DIR` location. Below is the explanation for each field.

```bash
# Network type: mainnet|testnet
NETWORK=mainnet

# Node type: client|sealer
NODE_TYPE=client

# Chain ID for the chain
CHAIN_ID=2019

# Data directory where all geth data will go
DATA_DIR=/home/ubuntu/.naka/mainnet

# Account which will be imported into the sealer. This will serve as the etherbase account.
ACCOUNT_ADDRESS=0x0000000000000000000000000000000000000000

# Password file for the account. Plain text file with the account's password.
PW_FILE=/home/ubuntu/.naka/mainnet/.accountpw

# Private key file for the account. Plain text file with the account's private key.
PK_FILE=/home/ubuntu/.naka/mainnet/.accountpk

# Port where the node will listen for other nodes trying to connect
LISTEN_PORT=30303

# Comma-separated values for all the bootnodes
BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301

# Bootnode key if you are running a bootnode on this server (optional)
BOOTNODE_KEY=
```

## Logging

The different log files are located at:

```text
/var/log/geth/mainnet/geth.log
/var/log/geth/testnet/geth.log
/var/log/geth/mainnet/bootnode.log
/var/log/geth/testnet/bootnode.log
```

### Setup Automatic Log Rotation

For adding automatic log rotations, open `/etc/logrotate.conf` and add the following.

```text
/var/log/geth/mainnet/geth.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}

/var/log/geth/testnet/geth.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
```

## Start Node

```bash
sudo systemctl start geth
```

## Stop Node

```bash
sudo systemctl stop geth
```

## Check Node Status

```bash
systemctl status geth
```

## Attach Geth Console

```bash
/script/attach.sh [mainnet|testnet]
```

## Changing Data Dir

If you want to use a different data directory location you will have to change the following:

1. `DATA_DIR` in your .env file
2. `DATA_DIR_ROOT` in `init.sh`
3. `EnvironmentFile` and `ExecStart` fields in each `*.service` file
