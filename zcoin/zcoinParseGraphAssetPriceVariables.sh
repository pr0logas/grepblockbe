#!/usr/bin/env bash

. ~/grepblock/zcoin/zcoinDefaults.sh

# File names
file="assetPrice.json"
formatingFile="./JSON/assetPrice.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"


apiProvider="api.coingecko.com"
unixTime=$(date +%s)

# Start parsing
source ~/grepblock/parseGraphAssetPrice.sh
