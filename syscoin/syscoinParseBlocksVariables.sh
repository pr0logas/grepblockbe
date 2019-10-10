#!/usr/bin/env bash

. ~/grepblock/syscoin/syscoinDefaults.sh

parseBlocksInRangeFor=199

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
