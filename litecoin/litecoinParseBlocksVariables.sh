#!/usr/bin/env bash

. ~/grepblock/litecoin/litecoinDefaults.sh

parseBlocksInRangeFor=299

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
