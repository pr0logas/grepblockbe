#!/usr/bin/env bash

. ~/grepblock/dash/dashDefaults.sh

collectionHistoricalPrices="historicalPriceData"
dataFileHistoricalPrices=/tmp/${database}-parsedHistoricalPrice.json
apiProvider="api.coingecko.com"
unixTime=$(date +%s)
vsCurrencyUSD="usd"
vsCurrencyBTC="btc"

# Start parsing
source ~/grepblock/parseHistoricalPrice.sh
