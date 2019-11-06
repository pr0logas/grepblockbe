#!/usr/bin/env bash

. ~/grepblock/reddcoin/reddcoinDefaults.sh

file="assetTransactions.json"
formatingFile="./JSON/assetTransactions.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetTransactions2.sh
