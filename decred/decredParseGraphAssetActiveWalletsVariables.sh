#!/usr/bin/env bash

. ~/grepblock/decred/decredDefaults.sh

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
