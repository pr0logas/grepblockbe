#!/usr/bin/env bash

. ~/grepblock/pivx/pivxDefaults.sh

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
source ~/grepblock/parseGraphAssetActiveWallets.sh
