#!/bin/sh
# build.sh
# Builds a testnet client node

TAG_NAME=v1.5.0

docker build \
-f ../../dockerfiles/Dockerfile.client \
-t "nakachain/client-testnet:$TAG_NAME" \
--build-arg GENESIS_PATH=./metadata/testnet/genesis.json \
--build-arg STATIC_NODES_PATH=./metadata/testnet/static-nodes.json \
--build-arg EXPOSED_PORTS="9545 9546 40303" \
--build-arg CHAIN_ID=2018 \
--build-arg BOOTNODES=enode://64b6b3687e748673f192c4967719677ef90e67083435364a85e714e870d343b93ebe8561cdff9d347db86af12aee490f9a2b012e4b80dc31e767b871fe6b7ea5@52.197.11.72:40301,enode://91e79afcbe2831689ee334ae264b0f4ae0c53b8918af56bee134d02458fa8bfc14a0f52e8452ee21065c44431cf72c36a403883dddac4d33c34eaa9e6421099c@52.9.128.68:40301 \
../../../
