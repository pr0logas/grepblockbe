#!/usr/bin/env bash

. ~/grepblock/adeptio/adeptioDefaults.sh

chainProvider="https://explorer.adeptio.cc"
getTx='/api/getrawtransaction?txid='

collectionWallets=wallets
dataFileWallets=/tmp/${database}-parsedWallets.json
dataFileWallets2=/tmp/${database}-parsedWallets2.json
dataFileWallets3=/tmp/${database}-parsedWallets3.json

# Start parsing
source ~/grepblock/parseWallets/${database}/curlParseWallets.sh
