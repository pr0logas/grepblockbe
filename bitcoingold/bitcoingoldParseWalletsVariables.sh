#!/usr/bin/env bash

. ~/grepblock/bitcoingold/bitcoingoldDefaults.sh

chainProvider="https://btgexplorer.com"
getTx='/api/tx/'

collectionWallets=wallets
dataFileWallets=/tmp/${database}-parsedWallets.json
dataFileWallets2=/tmp/${database}-parsedWallets2.json
dataFileWallets3=/tmp/${database}-parsedWallets3.json

# Start parsing
source ~/grepblock/curlInsightParseWallets.sh
