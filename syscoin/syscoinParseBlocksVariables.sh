#!/usr/bin/env bash

. ~/grepblock/syscoin/syscoinDefaults.sh

parseBlocksInRangeFor=199

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

chainProvider="http://explorer.blockchainfoundry.co"
getBlockHashMethod='/api/getblockhash?index='
getBlockwithHashMethod='/api/getblock?hash='

# Start parsing
source ~/grepblock/curlParseBlock.sh

