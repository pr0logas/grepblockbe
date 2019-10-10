#!/usr/bin/env bash

. ~/grepblock/polis/polisDefaults.sh

parseBlocksInRangeFor=199

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
