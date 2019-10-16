#!/usr/bin/env bash

. ~/grepblock/ravencoin/ravencoinDefaults.sh

parseBlocksInRangeFor=5

chainProvider="https://explorer.ravencoin.world"
getBlockHashMethod="/api/getblockhash?index\="
getBlockwithHashMethod="/api/getblock?hash\="

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
