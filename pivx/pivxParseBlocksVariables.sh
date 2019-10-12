#!/usr/bin/env bash

. ~/grepblock/pivx/pivxDefaults.sh

parseBlocksInRangeFor=199
chainProvider="https://mainnet-explorer.pivx.org"

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
