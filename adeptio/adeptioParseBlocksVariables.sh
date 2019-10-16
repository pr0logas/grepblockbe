#!/usr/bin/env bash

. ~/grepblock/adeptio/adeptioDefaults.sh

parseBlocksInRangeFor=5

chainProvider="https://explorer.adeptio.cc"
getBlockHashMethod="/api/getblockhash?index\="
getBlockwithHashMethod="/api/getblock?hash\="


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlParseBlock.sh
