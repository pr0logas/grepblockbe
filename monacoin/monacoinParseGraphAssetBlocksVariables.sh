#!/usr/bin/env bash

. ~/grepblock/monacoin/monacoinDefaults.sh

file="assetBlocks.json"
formatingFile="./JSON/assetBlocks.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetBlocks.sh
