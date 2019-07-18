#!/bin/sh
# build.sh
# Builds a mainnet client node

TAG_NAME=v1.5.0

docker build \
-f ../../dockerfiles/Dockerfile.client \
-t "nakachain/client-mainnet:$TAG_NAME" \
--build-arg GENESIS_PATH=./metadata/mainnet/genesis.json \
--build-arg STATIC_NODES_PATH=./metadata/mainnet/static-nodes.json \
--build-arg EXPOSED_PORTS="8545 8546 30303" \
--build-arg CHAIN_ID=2019 \
--build-arg BOOTNODES=enode://29808ed7af11bc46b38b9eab91db47ec40e4733fdc7684183655e2ed2a262676ce5bed031fb79750035f229b0d4288cdc3ead13b777704535aabedad2d4ff8b5@52.197.11.72:30301,enode://d0ca807148c8ca9900ed3c479b2025a8a80ca9e1102b6efc4b058103c0cf25d054a71651768bf7648810866fbea384b22f3d66e16c680195ea2717da986374df@52.9.128.68:30301,enode://ffed101f9e2f79994dfe1d0e58b56be7a5e98538d85319f94ac85e0cae9292c1017ba6be7d107b17aaf78c4f46f19caea2332a93da7725910c2112d11347665d@35.181.105.86:30301 \
../../../
