#!/usr/bin/env bash

. ~/grepblock/safeinsure/safeinsureDefaults.sh

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
