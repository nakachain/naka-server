#!/bin/sh
# Starts a bootnode independently and sends to the background

nohup \
bootnode \
-addr ":$BOOTNODE_PORT" \
-nodekey $BOOTNODE_KEY \
-verbosity 9 \
&
