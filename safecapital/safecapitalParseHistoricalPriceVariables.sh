#!/usr/bin/env bash

. ~/grepblock/safecapital/safecapitalDefaults.sh

collectionHistoricalPrices="historicalPriceData"
dataFileHistoricalPrices=/tmp/${database}-parsedHistoricalPrice.json
vsCurrencyUSD="usd"
vsCurrencyBTC="btc"

# Start parsing
source ~/grepblock/parsePrices/${database}/parseHistoricalPrice.sh
