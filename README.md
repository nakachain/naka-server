# Naka Server

This repo contains all the necessary config and scripts to run [go-naka](https://github.com/nakachain/go-naka) nodes.

## Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM
4. Rsyslog installed

## New Node Setup

Please note this setup is meant for deployment on AWS EC2 Linux instances where the default user is `ubuntu`, but can be adjusted to your environment. **If your default user is not `ubuntu`, see [changing data dir](#changing-data-dir) for instructions.**

1. Clone repo
2. Create the `.naka` data directory in your home directory: `~/.naka`
3. [Create env file](#environment-setup)
4. Create the `PW_FILE` if you are attaching an account to the node
5. Create the `PK_FILE` if you are attaching an account to the node
6. Create the `BOOTNODE_KEY` if you are running a bootnode
7. [Setup log rotations](#setup-automatic-log-rotation)
8. `cd naka-server/script`
9. Download the required binaries by running `./download-bin.sh`
10. Run init script and pass in your newly-created .env file: `./init.sh ~/.naka/mainnet/.env`
11. Use the [system command](#start-service) to start the bootnode
12. Use the [system command](#start-service) to start the node

**Note: all system services automatically auto-run on reboots.**

## Changing Data Dir

If your default user is not `ubuntu` you will need to change the following. The default `DATA_DIR_ROOT` is set to `/home/ubuntu/.naka`.

1. `EnvironmentFile` and `ExecStart` fields in each `services/*.service` file
2. `DATA_DIR` in your .env file
3. `BOOTNODE_KEY` in your .env file (if running a bootnode)
4. `PW_FILE` in your .env file (if attaching an account)
5. `PK_FILE` in your .env file (if attaching an account)

## Environment Setup

- [Chain ID](https://docs.nakachain.org/docs/nakachain-metadata/#chain-id)
- [Bootnodes](https://docs.nakachain.org/docs/nakachain-metadata/#bootnodes)
- Default mainnet .env location: `~/.naka/mainnet/.env`
- Default testnet .env location: `~/.naka/testnet/.env`

### Client Env

See `example-client.env` for an example. You will need to create an `.env` file in the `DATA_DIR` location. Below is the explanation for each field.

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
BOOTNODE_KEY=/home/ubuntu/.naka/mainnet/boot.key

# Bootnode port where it will listen for incoming connections
BOOTNODE_PORT=30301
```

### Sealer Env

See `example-sealer.env` for an example. You will need to create an `.env` file in the `DATA_DIR` location. Below is the explanation for each field.

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
BOOTNODE_KEY=/home/ubuntu/.naka/mainnet/boot.key

# Bootnode port where it will listen for incoming connections (optional)
BOOTNODE_PORT=30301
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

For adding automatic log rotations, create a new config file at `/etc/logrotate.d` and add the following.

```bash
$ sudo vim /etc/logrotate.d/naka

# Paste the config below and save the file
/var/log/geth/mainnet/geth.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
/var/log/geth/mainnet/bootnode.log {
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
/var/log/geth/testnet/bootnode.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
```

## Services

After running the `init.sh` script, you will now have systemd service(s) added. These are the following services depending on your env config:

```bash
geth_client_mainnet
geth_client_testnet
geth_sealer_mainnet
geth_sealer_testnet
bootnode_mainnet
bootnode_testnet
```

### Start Service

```bash
sudo systemctl start SERVICE_NAME
```

### Stop Service

```bash
sudo systemctl stop SERVICE_NAME
```

### Check Status

```bash
systemctl status SERVICE_NAME
```

## Attach Geth Console

```bash
scripts/attach.sh
```
