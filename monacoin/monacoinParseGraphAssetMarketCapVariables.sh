#!/usr/bin/env bash

. ~/grepblock/monacoin/monacoinDefaults.sh

# File names
file="assetMarketCap.json"
formatingFile="./JSON/assetMarketCap.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetMarketCapQuick.sh
