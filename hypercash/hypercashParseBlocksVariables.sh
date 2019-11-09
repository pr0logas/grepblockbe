#!/usr/bin/env bash

. ~/grepblock/hypercash/hypercashDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlParseBlock.sh
