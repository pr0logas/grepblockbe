#!/usr/bin/env bash

# :: Create JSON directory if it's not exist ::
mkdir -p ./JSON/

function setTimeStamp() {
        setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
}

function startCountingProcessTime() {
        start=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime() {
        end=$(($(date +%s%N)/1000000))
}

if [ -s $formatingFile ]; then
		
        echo ""
        echo "Found data in file. All Good. Continuing progress and appending only new data..."
		echo ""

else
		echo ""
        echo "Warning! data file is empty. Flushing first parameters and starting from zero!"
        echo ""
        echo $addCurlyBracketsStart >> $formatingFile
        echo " \"name\" : \"Difficulty\"" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"unit\" : \"Difficulty\"" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"period\" : \"day\"" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"values\" : " >> $formatingFile
        echo $addBracketsStart >> $formatingFile
        echo $addCurlyBracketsStart >> $formatingFile
        echo " \"x\" : ${genesisBlock}" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"y\" : 0" >> $formatingFile
        echo $addCurlyBracketsEnd >> $formatingFile
        echo $addBracketsEnd >> $formatingFile
        echo $addCurlyBracketsEnd >> $formatingFile
fi

# Check last progress
lastProgress=$(tail -n10 $formatingFile  | grep x | grep -o '[0-9]*')

# Check if DB works
mongo --host $mongoHost --port $mongoPort --eval "db.historicalPriceData.find({\"time\" : $lastProgress}).limit(1);" --quiet $database > /dev/null

if [[ $? -eq 0 ]]; then
        echo "DB works" > /dev/null
else
        echo "Database not working?" 
	exit 1
fi

# LastProgress (Last actual value)
lastProgressInDB2=$(mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {time:1, _id:0}).sort({$natural: -1}).limit(1);' --quiet $database | grep -o -P '."time".{0,16}' | head -1 | grep -o '[0-9]*')

for (( ; ; ))
        do

	startCountingProcessTime
        # Check last progress
        lastProgress=$(tail -n10 $formatingFile  | grep x | grep -o '[0-9]*')
	
	averageBlkMinus=$(echo "86400 - $blockTime" | bc)	

	lastProgress=$(echo "$lastProgress + $averageBlkMinus" | bc) 

        # LastProgress Time in DB
        lastProgressInDB1=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"time\" : { \$gt: $lastProgress}}).sort({\$natural: 1}).limit(1)" --quiet $database | grep -o -P '."time".{0,16}' | head -1 | grep -o '[0-9]*')

	if [ -z "$lastProgressInDB1" ]; then
		setTimeStamp
      		echo "$setDateStamp No new info on database. We at $ConvertUnixTime. Sleeping..."
		echo ""
		exit 0
	else
      		echo "" > /dev/null
	fi

        # Search for USD price
        searchingForPrice=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"time\" : $lastProgressInDB1}, {difficulty:1, _id:0}).limit(1)" --quiet $database | grep -o '[0-9,.-.]*')

                                # Format JSON
                                sed -i '$ d' $formatingFile
                                sed -i '$ d' $formatingFile
                                echo $addComma >> $formatingFile

                                echo $addCurlyBracketsStart >> $formatingFile
                                echo " \"x\" : ${lastProgressInDB1}" >> $formatingFile
                                echo $addComma >> $formatingFile
                                echo " \"y\" : ${searchingForPrice}" >> $formatingFile
                                echo $addCurlyBracketsEnd >> $formatingFile
                                echo $addComma >> $formatingFile

                                # Format JSON
                                sed -i '$ d' $formatingFile
                                echo $addBracketsEnd >> $formatingFile
                                echo $addCurlyBracketsEnd >> $formatingFile
                                sed -i '/^[[:space:]]*$/d' $formatingFile

		ConvertUnixTime=$(date -d @${lastProgressInDB1} +'%Y-%m-%d')
		stopCountingProcessTime		
		setTimeStamp
		runtime=$((end-start))
		echo "$setDateStamp Difficulty: ${searchingForPrice} we at $ConvertUnixTime now. Processing: $runtime ms."

                # Copy JSON to production
                scp ${formatingFile} root@${websiteHost}:/usr/share/nginx/grepblockcom/apidata/${assetTicker}/${file}
done

