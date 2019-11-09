#!/usr/bin/env bash

. ~/grepblock/adeptio/adeptioDefaults.sh

file="assetTransactions.json"
formatingFile="./JSON/assetTransactions.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetTransactions.sh
