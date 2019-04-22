#!/bin/sh

export $(cat .env | xargs) && ../../sealer/start-node-no-docker.sh
