#!/usr/bin/env bash

. ~/grepblock/ontology/ontologyDefaults.sh

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
