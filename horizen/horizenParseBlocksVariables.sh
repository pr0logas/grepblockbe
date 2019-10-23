#!/usr/bin/env bash

. ~/grepblock/horizen/horizenDefaults.sh

parseBlocksInRangeFor=999

chainProvider="https://explorer.horizen.cc"
getBlockHashMethod="/api/getblockhash?index\="
getBlockwithHashMethod="/api/getblock?hash\="


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
