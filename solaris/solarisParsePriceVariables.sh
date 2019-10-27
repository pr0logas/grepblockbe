#!/usr/bin/env bash

. ~/grepblock/solaris/solarisDefaults.sh

collectionBtcPrices=priceDataBTC
collectionUsdPrices=priceDataUSD
dataFilePrices=/tmp/${database}-parsedPrice.json
apiProvider="api.coingecko.com"
unixTime=$(date +%s)
vsCurrencyUSD="usd"
vsCurrencyBTC="btc"

# Start parsing
source ~/grepblock/parsePrice.sh
