#!/usr/bin/env bash

. ~/grepblock/bitcoingold/bitcoingoldDefaults.sh

parseBlocksInRangeFor=59

chainProvider="https://btgexplorer.com"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
