#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=hypercash
assetTicker="XLR"
assetName="hypercash"
genesisBlock=1572355036
coinGeckoStartUnixTime="1512864000"
blockTime=60

# RPC
rpcconnect=10.10.100.201
rpcport=1111
rpcuser=grepblock
rpcpassword=tothemoon

parseBlocksInRangeFor=99

chainProvider="https://explorer.hypercashplatform.com"
getBlockHashMethod='/api/getblockhash?index='
getBlockwithHashMethod='/api/getblock?hash='
getTx='/api/getrawtransaction?txid='

apiProvider="api.coingecko.com"
unixTime=$(date +%s)
#
daemonCli="hypercash-cli"
