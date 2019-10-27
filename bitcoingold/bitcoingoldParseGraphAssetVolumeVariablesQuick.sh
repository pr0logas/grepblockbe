#!/usr/bin/env bash

. ~/grepblock/bitcoingold/bitcoingoldDefaults.sh

# File names
file="assetVolume.json"
formatingFile="./JSON/assetVolume.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"


apiProvider="api.coingecko.com"
unixTime=$(date +%s)

# Start parsing
source ~/grepblock/parseGraphAssetVolumeQuick.sh
