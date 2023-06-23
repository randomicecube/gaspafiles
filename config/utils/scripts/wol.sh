#!/usr/bin/env bash

MAC_ADDRESS_FILE=$(basename $1)
HOSTNAME=$2
SECRETS_DIR=$3

# Wake on LAN script
cd $SECRETS_DIR
MAC_ADDRESS=$(agenix -d $MAC_ADDRESS_FILE)
wol --host=$HOSTNAME --port=9 $MAC_ADDRESS

