#!/usr/bin/env bash

. ~/grepblock/bitcoingold/bitcoingoldDefaults.sh

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
source ~/grepblock/parseGraphAssetMarketCapQuick.sh
