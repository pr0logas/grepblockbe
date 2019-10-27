#!/usr/bin/env bash

. ~/grepblock/zcash/zcashDefaults.sh

parseBlocksInRangeFor=19

chainProvider="https://zcashnetwork.info"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
