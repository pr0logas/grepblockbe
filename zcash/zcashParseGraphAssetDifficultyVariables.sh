#!/usr/bin/env bash

. ~/grepblock/zcash/zcashDefaults.sh

# File names
file="assetDifficulty.json"
formatingFile="./JSON/assetDifficulty.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphAssetDifficulty.sh
