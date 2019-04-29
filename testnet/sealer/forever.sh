#!/bin/sh
while [ true ]
do
    export $(cat .env | xargs) && ../../node-sealer/start-node-nohup.sh
    sleep 1
done
