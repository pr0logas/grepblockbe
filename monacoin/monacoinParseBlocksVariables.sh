#!/usr/bin/env bash

. ~/grepblock/monacoin/monacoinDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlInsightParseBlock.sh
