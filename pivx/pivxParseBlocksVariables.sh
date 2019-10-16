#!/usr/bin/env bash

. ~/grepblock/pivx/pivxDefaults.sh

parseBlocksInRangeFor=5
chainProvider="https://mainnet-explorer.pivx.org"
getBlockHashMethod="/api/getblockhash?index\="
getBlockwithHashMethod="/api/getblock?hash\="

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlParseBlock.sh
