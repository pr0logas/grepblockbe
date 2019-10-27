#!/usr/bin/env bash

. ~/grepblock/pivx/pivxDefaults.sh

chainProvider="https://mainnet-explorer.pivx.org"
getTx='/api/getrawtransaction?txid='

collectionWallets=wallets
dataFileWallets=/tmp/${database}-parsedWallets.json
dataFileWallets2=/tmp/${database}-parsedWallets2.json
dataFileWallets3=/tmp/${database}-parsedWallets3.json

# Start parsing
source ~/grepblock/curlParseWallets.sh
