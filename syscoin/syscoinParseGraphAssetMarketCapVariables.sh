#!/usr/bin/env bash

. ~/grepblock/syscoin/syscoinDefaults.sh

# File names
file="assetMarketCap.json"
formatingFile="./JSON/assetMarketCap.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"


apiProvider="api.coingecko.com"
unixTime=$(date +%s)

# Start parsing
source ~/grepblock/parseGraphAssetMarketCap.sh
