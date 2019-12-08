#!/usr/bin/env bash

. ~/grepblock/safecapital/safecapitalDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlInsightParseBlock.sh
