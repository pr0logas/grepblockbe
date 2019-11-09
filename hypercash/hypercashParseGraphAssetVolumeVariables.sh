#!/usr/bin/env bash

. ~/grepblock/hypercash/hypercashDefaults.sh

# File names
file="assetVolume.json"
formatingFile="./JSON/assetVolume.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"

# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetPriceQuick.sh
