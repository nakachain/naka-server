#!/bin/sh
export $(cat .env | xargs) && ../../script/init.sh
