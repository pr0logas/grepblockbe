#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database='safeinsure'
assetTicker="SINS"
assetName="safeinsure"
genesisBlock=1537180653
coinGeckoStartUnixTime="1538006400"
blockTime=60

# RPC
rpcconnect=10.10.100.201
rpcport=1111
rpcuser=grepblock
rpcpassword=tothemoon

parseBlocksInRangeFor=99

apiProvider="api.coingecko.com"
unixTime=$(date +%s)
#
daemonCli="safeinsure-cli"
