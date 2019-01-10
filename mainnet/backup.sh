#!/bin/sh

VOLUME_DATA="$(docker volume inspect mainnet_mainnet-client-data)"
echo "${VOLUME_DATA}"