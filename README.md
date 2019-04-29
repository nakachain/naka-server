# Naka Server

This repo contains all the necessary Docker config and scripts to run [Nakachain](https://github.com/nakachain/go-naka) nodes.

## Requirements

1. Linux-based AMD64 arch type OS

## New Node Setup (Linux)

1. Clone repo
2. `cd naka-server/script`
3. `./download-bin.sh`
4. `cd ../[mainnet/testnet]/[sealer/client]`
5. Create env file with `vim .env`:

        # Example .env for mainnet client
        CHAIN_ID=2019
        BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301
        LOG_DIR=/var/log/geth
        DATA_DIR=/home/ubuntu/.naka/mainnet
        SERVICE_FILE=/home/ubuntu/naka-server/mainnet/client/geth.service
        SYSLOG_CONF_FILE=/home/ubuntu/naka-server/script/geth.conf
        GENESIS_FILE=/home/ubuntu/naka-server/mainnet/genesis.json
        STATIC_NODE_FILE=/home/ubuntu/naka-server/mainnet/static-nodes.json

6. Run init script: `./init.sh`. This creates a Linux system service.
7. `cd ../../script`
8. `./start.sh` to start the node
9. Note that the geth system service is now setup to auto-run on reboots.

## Check Node Status

To check the geth system service status, run `systemctl status geth`.

## Stopping Node

To stop your running node, run `/script/stop.sh`.

## Attach Geth Console

To attach to your runnning node, run `/script/attach.sh [mainnet/testnet]`.

## Logging

Logs are stored and rotated in `/var/log/geth/geth.log`.
