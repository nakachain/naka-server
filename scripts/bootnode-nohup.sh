#!/bin/sh
# Starts a bootnode independently and sends to the background

nohup \
bootnode \
-nodekey $BOOTNODE_KEY \
-verbosity 9 \
&
