#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database='safecapital'
assetTicker="SCAP"
assetName="safecapital"
genesisBlock=1573453155
coinGeckoStartUnixTime="1574294400"
blockTime=60

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
daemonCli="safecapital-cli"
