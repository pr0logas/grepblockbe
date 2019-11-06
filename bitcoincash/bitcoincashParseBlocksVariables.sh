#!/usr/bin/env bash

. ~/grepblock/bitcoincash/bitcoincashDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/curlInsightParseBlock.sh
