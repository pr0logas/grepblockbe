#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=horizen
assetTicker="ZEN"
assetName="zencash"
genesisBlock=1478414242
coinGeckoStartUnixTime="1500076800"
blockTime=150

# RPC
rpcconnect=10.10.100.28
rpcport=18231
rpcuser=grepblockuser
rpcpassword=grepblocktothemoon

parseBlocksInRangeFor=999

chainProvider="https://explorer.horizen.cc"
getBlockHashMethod='/api/getblockhash?index='
getBlockwithHashMethod='/api/getblock?hash='


#
daemonCli="zen-cli"
