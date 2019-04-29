# Naka Server

This repo contains all the necessary config and scripts to run [Nakachain](https://github.com/nakachain/go-naka) nodes.

## Linux AMD64 OS

### Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM

### New Node Setup

1. Clone repo
2. `cd naka-server/script`
3. Download the required binaries: `./download-bin.sh`
4. `cd ../[mainnet/testnet]/[sealer/client]`
5. Create env file: `vim .env`

        # Example .env for mainnet client
        CHAIN_ID=2019
        BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301
        LOG_DIR=/var/log/geth
        DATA_DIR=/home/ubuntu/.naka/mainnet
        SERVICE_FILE=/home/ubuntu/naka-server/mainnet/client/geth.service
        SYSLOG_CONF_FILE=/home/ubuntu/naka-server/script/geth.conf
        GENESIS_FILE=/home/ubuntu/naka-server/mainnet/genesis.json
        STATIC_NODE_FILE=/home/ubuntu/naka-server/mainnet/static-nodes.json

6. Run init script: `./init.sh`. This creates a Linux system service for geth among other necessary setup.
7. `cd ../../script`
8. `./start.sh` to start the node
9. Note that the geth system service is now setup to auto-run on reboots.

### Start Node

```bash
/script/start.sh
```

### Stop Node

```bash
/script/stop.sh
```

### Check Node Status

```bash
systemctl status geth
```

### Attach Geth Console

```bash
/script/attach.sh [mainnet/testnet]
```

### Logging

Logs are stored and rotated in `/var/log/geth/geth.log`.
