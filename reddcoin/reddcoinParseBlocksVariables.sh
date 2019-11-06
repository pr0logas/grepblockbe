#!/usr/bin/env bash

. ~/grepblock/reddcoin/reddcoinDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
