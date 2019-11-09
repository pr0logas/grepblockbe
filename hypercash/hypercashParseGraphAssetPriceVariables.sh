#!/usr/bin/env bash

. ~/grepblock/hypercash/hypercashDefaults.sh

# File names
file="assetPrice.json"
formatingFile="./JSON/assetPrice.json"

# Misc
addComma=","
addBracketsStart="["
addBracketsEnd="]"
addCurlyBracketsEnd="}"
addCurlyBracketsStart="{"


# Start parsing
source ~/grepblock/parseGraphs/${database}/parseGraphAssetPriceQuick.sh
