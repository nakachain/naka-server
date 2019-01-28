# Naka Server
This repo contains all the necessary Docker config and scripts to run [Nakachain](https://github.com/nakachain/go-naka) nodes.

## Chain ID
**Mainnet**
```
2019
```

**Testnet**
```
2018
```

## Bootnodes
**Mainnet**
```
enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301
enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301
enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301
```

**Testnet**
```
enode://64b6b3687e748673f192c4967719677ef90e67083435364a85e714e870d343b93ebe8561cdff9d347db86af12aee490f9a2b012e4b80dc31e767b871fe6b7ea5@52.192.98.2:30301
enode://91e79afcbe2831689ee334ae264b0f4ae0c53b8918af56bee134d02458fa8bfc14a0f52e8452ee21065c44431cf72c36a403883dddac4d33c34eaa9e6421099c@54.241.157.193:30301
```

## Client Node
Client nodes are non-sealer nodes.

**Setup**
1. `cd [mainnet/testnet]/client`
2. Create `.env` file. You need to specify: `CHAIN_ID, BOOTNODES`. Do not use any quotes around strings.

        CHAIN_ID=2019
        BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@13.53.210.165:30301

**Start**
```
$ cd [mainnet/testnet]/client
$ docker-compose up --build -d
```

**Stop**
```
$ cd [mainnet/testnet]/client
$ docker-compose down
```

## Sealer Node
Sealer nodes help write transactions to the blockchain. You will need to be voted in to become a Sealer node.

**Setup**
1. `cd [mainnet/testnet]/client`
2. Create `.env` file. You need to specify: `CHAIN_ID, ETHERBASE_ADDRESS, ACCOUNT_ADDRESS, ACCOUNT_PRIVATE_KEY, ACCOUNT_PASSWORD, BOOTNODES`. Do not use any quotes around strings.

        CHAIN_ID=2018
        ETHERBASE_ADDRESS=0xYOUR_ADDRESS
        ACCOUNT_ADDRESS=0xYOUR_ADDRESS
        ACCOUNT_PRIVATE_KEY=YOUR_PRIVATE_KEY
        ACCOUNT_PASSWORD=YOUR_PASSWORD
        BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.194.7.60:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.174.142:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@35.181.10.67:30301

**Start**
```
$ cd [mainnet/testnet]/client
$ docker-compose up --build -d
```

**Stop**
```
$ cd [mainnet/testnet]/client
$ docker-compose down
```

## Attaching To Node
```
$ docker ps
// copy the CONTAINER ID of the node you want to connect to
$ ./attach $CONTAINER_ID
```
