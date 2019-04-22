#!/bin/sh

export $(cat .env | xargs) \
&& nohup ../../script/sealer/start-node-no-docker.sh >> ../../logs/geth.log &
