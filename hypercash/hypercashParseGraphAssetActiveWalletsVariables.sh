#!/usr/bin/env bash

. ~/grepblock/hypercash/hypercashDefaults.sh

# File names
file="assetActiveWallets.json"
formatingFile="./JSON/assetActiveWallets.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetActiveWallets.sh
