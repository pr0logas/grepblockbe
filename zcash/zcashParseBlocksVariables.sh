#!/usr/bin/env bash

. ~/grepblock/zcash/zcashDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
