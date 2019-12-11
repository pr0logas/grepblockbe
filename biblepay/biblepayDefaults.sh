#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database='biblepay'
assetTicker="BBP"
assetName="biblepay"
genesisBlock=1500844608
coinGeckoStartUnixTime="1538006400"
blockTime=420

# RPC
rpcconnect=10.10.100.201
rpcport=1111
rpcuser=grepblock
rpcpassword=tothemoon

parseBlocksInRangeFor=99

apiProvider="api.coingecko.com"
unixTime=$(date +%s)
#
daemonCli="biblepay-cli"
