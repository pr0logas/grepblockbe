#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database='deviantcoin'
assetTicker="DEV"
assetName="deviantcoin"
genesisBlock=1529783629
coinGeckoStartUnixTime="1522368000"
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
daemonCli="deviantcoin-cli"
