#!/usr/bin/env bash

set -x 

# Check if we have a collection created
check=$(mongo --host $mongoHost --port $mongoPort --eval 'db.historicalPriceData.find({}, {unix_time:1, _id:0}).sort({$natural: -1}).limit(1);' --quiet $database | jq -r '.unix_time')
        if [[ "$check" < 0 ]] ; then
                mongo --host $mongoHost --port $mongoPort --eval "db.historicalPriceData.insert({\"unix_time\" : ${coinGeckoStartUnixTime}});" --quiet $database
        else
        		echo ""
                echo "ALL good. Found existing data in DB. Continuing progress..."
                echo ""
        fi

#------------------------------------------------------------


# Check last value in MongoDB
lastValueInDB=$(mongo --host $mongoHost --port $mongoPort --eval 'db.historicalPriceData.find({}, {unix_time:1, _id:0}).limit(1).sort({$natural: -1}).limit(1);' --quiet $database | jq -r '.unix_time')

lastDateInDB=$(date -d @${lastValueInDB} +'%Y-%m-%d')
NEXT_DATE=$(date +%d-%m-%Y -d "$lastDateInDB + 1 day")
NextDayRevA=$(echo ${NEXT_DATE} | cut -c 1-2)
NextDayRevB=$(echo ${NEXT_DATE} | cut -c 4-6)
NextDayRevC=$(echo ${NEXT_DATE} | cut -c 7-10)
NextDayUnixTime=$(date -d "${NextDayRevC}-${NextDayRevB}-${NextDayRevA}" +%s)


keepValues=$(curl -s -X GET "https://${apiProvider}/api/v3/coins/${assetName}/history?date=${NEXT_DATE}&localization=false" -H  "accept: application/json")
echo $keepValues | grep "market_data" > /dev/null

                        if [ $? -eq 0 ]; then
                                setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                echo $keepValues > $dataFileHistoricalPrices
                                echo "$setDateStamp 200 $apiProvider responded with historical data of $NEXT_DATE - SUCCESS"

                                sed -i 's@\]@@g' $dataFileHistoricalPrices
                                sed -i 's@\[@@g' $dataFileHistoricalPrices
                                sed -i "s@{@{\"unix_time\"\: ${NextDayUnixTime}\,@g" $dataFileHistoricalPrices

                                mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionHistoricalPrices --file $dataFileHistoricalPrices --mode upsert --upsertFields unix_time --quiet

                                        if [ $? -eq 0 ]; then
                                        	setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                        	echo "${setDateStamp} SUCCESS historical price data of $NEXT_DATE flushed to database" 
                                            
                                        else
                                        
                                        	setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                        	echo "${setDateStamp} FAILED to flush historical price data of $NEXT_DATE to database - ERROR"
                                          	exit 1
                                            
                                        fi

                        else
                                setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                echo "$setDateStamp $apiProvider responded with empty data or error code for historical price of $NEXT_DATE. Sleeping right now and will retry later..."
 
                        fi
