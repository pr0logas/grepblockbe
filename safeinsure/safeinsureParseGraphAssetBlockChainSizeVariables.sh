#!/usr/bin/env bash

. ~/grepblock/safeinsure/safeinsureDefaults.sh

file="assetBlockchainSize.json"
formatingFile="./JSON/assetBlockchainSize.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetBlockchainSize.sh
