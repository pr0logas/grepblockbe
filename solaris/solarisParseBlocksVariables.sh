#!/usr/bin/env bash

. ~/grepblock/solaris/solarisDefaults.sh

parseBlocksInRangeFor=99

chainProvider="https://solaris.blockexplorer.pro"
getBlockHashMethod="/api/getblockhash?index\="
getBlockwithHashMethod="/api/getblock?hash\="


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlParseBlock.sh
