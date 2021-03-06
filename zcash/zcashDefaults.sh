#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=zcash
assetTicker="ZEC"
assetName="zcash"
genesisBlock=1477671596
coinGeckoStartUnixTime="1477785600"
blockTime=150

# RPC
rpcconnect=10.10.100.201
rpcport=11111
rpcuser=grepblock
rpcpassword=tothemoon

parseBlocksInRangeFor=2

chainProvider="https://zcashnetwork.info"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"
getTx='/api/tx/'


#
daemonCli="zcash-cli"
