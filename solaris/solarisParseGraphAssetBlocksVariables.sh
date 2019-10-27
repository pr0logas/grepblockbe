#!/usr/bin/env bash

. ~/grepblock/solaris/solarisDefaults.sh

file="assetBlocks.json"
formatingFile="./JSON/assetBlocks.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetBlocks2.sh
