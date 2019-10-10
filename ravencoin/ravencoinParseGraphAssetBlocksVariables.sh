#!/usr/bin/env bash

. ~/grepblock/ravencoin/ravencoinDefaults.sh

file="assetBlocks.json"
formatingFile="./JSON/assetBlocks.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetBlocks.sh
