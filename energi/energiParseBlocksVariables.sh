#!/usr/bin/env bash

. ~/grepblock/energi/energiDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlParseBlock.sh
