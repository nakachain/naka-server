#!/bin/sh

export $(cat .env | xargs) && ../../node-sealer/start-node-no-docker.sh
