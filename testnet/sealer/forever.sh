#!/bin/sh
until /home/ubuntu/naka-server/testnet/sealer/start.sh; do
    echo "Server crashed with exit code $?. Respawning..." >&2
    sleep 1
done
