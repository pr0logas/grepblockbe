#!/usr/bin/env bash

. ~/grepblock/snowgem/snowgemDefaults.sh

parseBlocksInRangeFor=20

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
