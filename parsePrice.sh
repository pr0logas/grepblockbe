#!/usr/bin/env bash

curl -s -X GET "https://${apiProvider}/api/v3/coins/markets?vs_currency=${vsCurrencyUSD}&ids=${assetName}&order=market_cap_desc&per_page=100&page=1&sparkline=false" -H  "accept: application/json" > $dataFilePrices
setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)

        if [ $? -eq 0 ]; then
                echo "$setDateStamp 200 $apiProvider responded with --USD-- data - SUCCESS" 
        else
                echo "$setDateStamp $apiProvider responded with error code for --USD-- data - FAIL"
                exit 1
        fi

sed -i 's@\]@@g' $dataFilePrices
sed -i 's@\[@@g' $dataFilePrices
sed -i "s@{@{\"unix_time\"\: ${unixTime}\,@g" $dataFilePrices

mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionUsdPrices --file $dataFilePrices --mode upsert --upsertFields unix_time --quiet
setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)

        if [ $? -eq 0 ]; then
                echo "${setDateStamp} SUCCESS price data --USD-- flushed to database $database" 
        else
                echo "${setDateStamp} FAILED to flush price data --USD-- to database - ERROR"
                exit 1
        fi

curl -s -X GET "https://${apiProvider}/api/v3/coins/markets?vs_currency=${vsCurrencyBTC}&ids=${assetName}&order=market_cap_desc&per_page=100&page=1&sparkline=false" -H  "accept: application/json" > $dataFilePrices
setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)

        if [ $? -eq 0 ]; then
                echo "$setDateStamp 200 $apiProvider responded with --BTC-- data - SUCCESS" 
        else
                echo "$setDateStamp $apiProvider responded with error code for --BTC-- data - FAIL"
                exit 1
        fi

sed -i 's@\]@@g' $dataFilePrices
sed -i 's@\[@@g' $dataFilePrices
sed -i "s@{@{\"unix_time\"\: ${unixTime}\,@g" $dataFilePrices

mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionBtcPrices --file $dataFilePrices --mode upsert --upsertFields unix_time --quiet
setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)

        if [ $? -eq 0 ]; then
                echo "$setDateStamp SUCCESS price data --BTC-- flushed to database $database" 
        else
                echo "$setDateStamp FAILED to flush price data --BTC-- to database - ERROR"
                exit 1
        fi
