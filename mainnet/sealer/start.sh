#!/bin/sh

export $(cat .env | xargs) && ../../script/sealer/start-node-no-docker.sh
