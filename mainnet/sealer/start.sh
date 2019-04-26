#!/bin/sh
export $(cat .env | xargs) && ../../node-sealer/start-node-nohup.sh
