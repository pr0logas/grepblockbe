#!/usr/bin/env bash

. ~/grepblock/hypercash/hypercashDefaults.sh

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
source ~/grepblock/parseGraphs/${database}/parseGraphAssetDifficulty.sh
