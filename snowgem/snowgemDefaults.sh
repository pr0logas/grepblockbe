#!/usr/bin/env bash

# Mongo
websiteHost=10.10.100.158
mongoHost=10.10.100.201
mongoPort=27017

#
database=snowgem
assetTicker="XSG"
assetName="snowgem"
genesisBlock=1514034481
coinGeckoStartUnixTime="1522540800"
blockTime=120

# RPC
rpcconnect=10.10.100.201
rpcport=16112
rpcuser=grepblock
rpcpassword=tothemoon

chainProvider="https://explorer.snowgem.org"
getTx='/api/tx/'
getBlockHashMethod='/api/block-index/'
getBlockwithHashMethod='/api/block/'

#
daemonCli="snowgem-cli"
