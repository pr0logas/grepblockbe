#!/usr/bin/env bash

. ~/grepblock/solaris/solarisDefaults.sh

collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlocks/${database}/curlParseBlock.sh
