#!/usr/bin/env bash

. ~/grepblock/litecoin/litecoinDefaults.sh

parseBlocksInRangeFor=99

chainProvider="https://insight.litecore.io"
getBlockHashMethod="api/block-index/"
getBlockwithHashMethod="/api/block/"

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
