#!/usr/bin/env bash

. ~/grepblock/horizen/horizenDefaults.sh


collectionBlocks=blocks
dataFileBlocks=/tmp/${database}-parsedBlock.json

# Start parsing
source ~/grepblock/parseBlock.sh
