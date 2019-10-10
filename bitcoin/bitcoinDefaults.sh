#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=bitcoin
assetTicker="BTC"
assetName="bitcoin"
genesisBlock=1231469665
coinGeckoStartUnixTime="1367280000"
blockTime=600

# RPC
rpcconnect=10.10.100.201
rpcport=8332
rpcuser=grepblockuser
rpcpassword=grepblocktothemoon

#
daemonCli="bitcoin-cli"
