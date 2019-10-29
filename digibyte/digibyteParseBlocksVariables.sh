#!/usr/bin/env bash

. ~/grepblock/digibyte/digibyteDefaults.sh

parseBlocksInRangeFor=199

getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
