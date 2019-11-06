#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=reddcoin
assetTicker="RDD"
assetName="reddcoin"
genesisBlock=1390771894
coinGeckoStartUnixTime="1391990400"
blockTime=60

# RPC
rpcconnect=10.10.100.201
rpcport=11111
rpcuser=grepblock
rpcpassword=tothemoon

# cURL
chainProvider="https://live.reddcoin.com"
parseBlocksInRangeFor=199
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"
getTx='/api/tx/'

#
daemonCli="reddcoin-cli"
