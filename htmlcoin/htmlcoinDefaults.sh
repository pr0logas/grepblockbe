#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database='htmlcoin'
assetTicker="HTML"
assetName="htmlcoin"
genesisBlock=1510744299
coinGeckoStartUnixTime="1516579200"
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
daemonCli="htmlcoin-cli"
