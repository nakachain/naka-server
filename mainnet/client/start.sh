#!/bin/sh
export $(cat .env | xargs) && ../../node-client/start-client-nohup.sh
