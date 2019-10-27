#!/usr/bin/env bash

. ~/grepblock/zcash/zcashDefaults.sh

file="assetBlockchainSize.json"
formatingFile="./JSON/assetBlockchainSize.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetBlockchainSize.sh