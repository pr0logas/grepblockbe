#!/usr/bin/env bash

. ~/grepblock/zcash/zcashDefaults.sh

# File names
file="assetInfo.json"
formatingFile="./JSON/assetInfo.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/assetInfo.sh
