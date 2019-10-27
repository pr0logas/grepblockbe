#!/usr/bin/env bash

. ~/grepblock/decred/decredDefaults.sh

parseBlocksInRangeFor=59

chainProvider="https://mainnet.decred.org"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
