#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=syscoin
assetTicker="SYS"
assetName="syscoin"
genesisBlock=1559677606
coinGeckoStartUnixTime="1412121600"
blockTime=60

# RPC
rpcconnect=10.10.100.201
rpcport=8370
rpcuser=grepblock
rpcpassword=tothemoon

getTx='/api/getrawtransaction?txid='
chainProvider="http://explorer.blockchainfoundry.co"
getBlockHashMethod='/api/getblockhash?index='
getBlockwithHashMethod='/api/getblock?hash='

#
daemonCli="syscoin-cli"
