#!/usr/bin/env bash

. ~/grepblock/monacoin/monacoinDefaults.sh

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
source ~/grepblock/assetInfo/${database}/assetInfo.sh
