#!/usr/bin/env bash

# :: Create JSON directory if it's not exist ::
mkdir -p ./JSON/

if [ -s $formatingFile ]; then

        echo ""
        echo "Found data in file. All Good. Continuing progress and appending only new data..."
                echo ""

else
                echo ""
        echo "Warning! data file is empty. Flushing first parameters and starting from zero!"
        echo ""
        setGoodTimeFormatSet=$(echo "$coinGeckoStartUnixTime * 1000" | bc)
        echo "[" >> $formatingFile
        echo "   [" >> $formatingFile
        echo "${setGoodTimeFormatSet}" >> $formatingFile
        echo $addComma >> $formatingFile
        echo "0" >> $formatingFile
        echo "   ]" >> $formatingFile
        echo "]" >> $formatingFile
fi

# Check last progress
lastProgress=$(tail -n5 $formatingFile | grep -o '[0-9]*' | head -1)

lastProgress=$(($lastProgress / 1000))

# Check if DB works
mongo --host $mongoHost --port $mongoPort --eval "db.historicalPriceData.find({\"unix_time\" : $lastProgress}).limit(1);" --quiet $database > /dev/null

if [[ $? -eq 0 ]]; then
	echo "DB works" > /dev/null
else 
	echo "Database not working?" 
	exit 1
fi

# LastProgress (Last actual value)
lastProgressInDB2=$(mongo --host $mongoHost --port $mongoPort --eval 'db.historicalPriceData.find({}, {unix_time:1, _id:0}).sort({$natural: -1}).limit(1);' --quiet $database | grep -o -P '."unix_time".{0,16}' | head -1 | grep -o '[0-9]*')

for (( ; ; ))
	do

	# Check last progress
	lastProgress=$(tail -n5 $formatingFile | grep -o '[0-9]*' | head -1)

	lastProgress=$(($lastProgress / 1000))

	# LastProgress Time in DB
	lastProgressInDB1=$(mongo --host $mongoHost --port $mongoPort --eval "db.historicalPriceData.find({\"unix_time\" : { \$gt: $lastProgress}}).limit(1)" --quiet $database | grep -o -P '."unix_time".{0,16}' | head -1 | grep -o '[0-9]*')
	# Search for USD price
	searchingForPrice=$(mongo --host $mongoHost --port $mongoPort --eval "db.historicalPriceData.find({\"unix_time\" : $lastProgressInDB1}, {_id:0}).limit(1)" --quiet $database | grep -o -P '"usd".{0,50}' | head -2 | tail -1 | sed 's@,.*@@' | grep -o '[0-9,.-.]*')

	if [[ "$lastProgressInDB1" -eq "$lastProgressInDB2" ]]; then
		echo "No new data on Database, sleeping..."
		exit 0
	else
		   if [ -z "$searchingForPrice" ]; then
                        searchingForPrice=null
                   else
                        echo "AllGood" > /dev/null
                   fi
                   
                setGraphTimeFormat=$(($lastProgressInDB1 * 1000))
                sed -i '$ d' $formatingFile
                echo $addComma >> $formatingFile
                echo "   [" >> $formatingFile
                echo "${setGraphTimeFormat}" >> $formatingFile
		echo $addComma >> $formatingFile
        	echo "${searchingForPrice}" >> $formatingFile
		echo "   ]" >> $formatingFile
		echo "]" >> $formatingFile
		
		# Copy JSON to production
                scp ${formatingFile} root@${websiteHost}:/usr/share/nginx/grepblockcom/apidata/${assetTicker}/${file}

                dateProgress=$(date -d @${lastProgressInDB1} +'%Y-%m-%d')
                setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                echo "$setDateStamp Added data to graph: $dateProgress & MarketCap: \$ ${searchingForPrice}"
	fi
done
