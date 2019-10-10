#!/usr/bin/env bash

. ~/grepblock/pivx/pivxDefaults.sh

parseBlocksInRangeFor=199

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
