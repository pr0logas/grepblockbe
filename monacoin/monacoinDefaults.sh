#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=monacoin
assetTicker="MONA"
assetName="monacoin"
genesisBlock=1388534484
coinGeckoStartUnixTime="1395273600"
blockTime=90

# RPC
rpcconnect=10.10.100.201
rpcport=1111
rpcuser=grepblock
rpcpassword=tothemoon

parseBlocksInRangeFor=99

chainProvider="https://mona.chainsight.info"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"
getTx='/api/tx/'

apiProvider="api.coingecko.com"
unixTime=$(date +%s)
#
daemonCli="monacoin-cli"
