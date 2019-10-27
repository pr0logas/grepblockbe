#!/usr/bin/env bash

. ~/grepblock/decred/decredDefaults.sh

chainProvider="https://mainnet.decred.org"
getTx='/api/tx/'

collectionWallets=wallets
dataFileWallets=/tmp/${database}-parsedWallets.json
dataFileWallets2=/tmp/${database}-parsedWallets2.json
dataFileWallets3=/tmp/${database}-parsedWallets3.json

# Start parsing
source ~/grepblock/curlInsightParseWallets.sh
