#!/usr/bin/env bash

. ~/grepblock/bitcoin/bitcoinDefaults.sh

file="assetTransactions.json"
formatingFile="./JSON/assetTransactions.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetTransactions.sh
