#!/usr/bin/env bash

. ~/grepblock/energi/energiDefaults.sh

collectionBtcPrices=priceDataBTC
collectionUsdPrices=priceDataUSD
dataFilePrices=/tmp/${database}-parsedPrice.json
vsCurrencyUSD="usd"
vsCurrencyBTC="btc"

# Start parsing
source ~/grepblock/parsePrices/${database}/parsePrice.sh
