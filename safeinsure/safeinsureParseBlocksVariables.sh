#!/usr/bin/env bash

. ~/grepblock/safeinsure/safeinsureDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlInsightParseBlock.sh
