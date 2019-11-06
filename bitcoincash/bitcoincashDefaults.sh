#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=bitcoin-cash
assetTicker="BCH"
assetName="bitcoin-cash"
genesisBlock=1231469665
coinGeckoStartUnixTime="1501718400"
blockTime=600

# RPC
rpcconnect=10.10.100.201
rpcport=18332
rpcuser=grepblockuser
rpcpassword=grepblocktothemoon

# cURL
chainProvider="https://blockdozer.com"
parseBlocksInRangeFor=199
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"
getTx='/api/tx/'

#
daemonCli="bitcoincash-cli"
