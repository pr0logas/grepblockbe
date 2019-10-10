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
        echo $addCurlyBracketsStart >> $formatingFile
        echo " \"name\" : \"Blocks\"" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"unit\" : \"Blocks\"" >> $formatingFile
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
mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"time\" : $lastProgress}).limit(1);" --quiet $database | grep -o -P '."block".{0,16}' | grep -o '[0-9]*' > /dev/null

if [ $? -eq 0 ]; then

        # LastProgress Time in DB
        lastProgressBlockInFile=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"time\" : $lastProgress}).limit(1);" --quiet $database | grep -o -P '."block".{0,16}' | grep -o '[0-9]*')

        # Last Block at that Time
        lastBlockInDB=$(mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {block:1, _id:0}).sort({$natural: -1}).limit(1);' --quiet $database | jq '.block')

        # Increase number in order to continue last progress
        lastProgressBlockInFile=$(($lastProgressBlockInFile + 1))

                # Start For loop from last progress till last block
                for (( i=${lastProgressBlockInFile}; i<=${lastBlockInDB}; i++ ))

                do
                
               	start=$(($(date +%s%N)/1000000))
               
                        blocks=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $i}, {block:1, _id:0})" --quiet $database | jq '.block' | wc -l)

                        # Check if DB works
                        mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $i}, {tx:1, _id:0})" --quiet $database | jq '.tx' | wc -l > /dev/null

                        if [ $? -eq 0 ]; then

                        unixTime=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $i}, {time:1, _id:0})" --quiet $database | jq '.time')

                        sumBlocks=$(($sumBlocks + $blocks))

                        ConvertUnixTime=$(date -d @${unixTime} +'%Y-%m-%d')
                        ThisDayRevA=$(echo ${ConvertUnixTime} | cut -c 9-10)
						
                        # Walk around of Octal bug in bash for IF comparison
                        formatThisDayRevA=$(echo $ThisDayRevA | sed 's@0@@g')
                        formatNextDayRevA=$(echo $NextDayRevA | sed 's@0@@g')


                        # Check if it's next day or not?
                        if [[ $formatThisDayRevA -eq $formatNextDayRevA ]]; then

                                # Format JSON
                                sed -i '$ d' $formatingFile
                                sed -i '$ d' $formatingFile
                                echo $addComma >> $formatingFile

                                echo $addCurlyBracketsStart >> $formatingFile
                                echo " \"x\" : ${unixTime}" >> $formatingFile
                                echo $addComma >> $formatingFile
                                echo " \"y\" : ${sumBlocks}" >> $formatingFile
                                echo $addCurlyBracketsEnd >> $formatingFile
                                echo $addComma >> $formatingFile

                                # Format JSON
                                sed -i '$ d' $formatingFile
                                echo $addBracketsEnd >> $formatingFile
                                echo $addCurlyBracketsEnd >> $formatingFile
                                sed -i '/^[[:space:]]*$/d' $formatingFile

                                # Copy JSON to production
                                scp ${formatingFile} root@${websiteHost}:/usr/share/nginx/grepblockcom/apidata/${assetTicker}/${file}
                                setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                echo "$setDateStamp Next day found. Total blocks: ${sumBlocks} we at $ConvertUnixTime now" 
                                sumBlocks=0

                        else
                                setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                end=$(($(date +%s%N)/1000000))
        						runtime=$((end-start))
                                checkHowManyLeft=$(echo "$lastBlockInDB - $i" | bc)
                                timeLeft=$(echo "$checkHowManyLeft / 86400" | bc) 
                                timeLeftRegardms=$(echo "$timeLeft * 0.${runtime}" | bc -l)
                                echo "$setDateStamp Counting blocks: ${sumBlocks}. Block: $i/$lastBlockInDB & $ConvertUnixTime. Processing: $runtime ms. Time left approx.: $timeLeftRegardms days"
                        fi

                        NEXT_DATE=$(date +%d-%m-%Y -d "$ConvertUnixTime + 1 day")
                        NextDayRevA=$(echo ${NEXT_DATE} | cut -c 1-2)
                        NextDayRevB=$(echo ${NEXT_DATE} | cut -c 4-6)
                        NextDayRevC=$(echo ${NEXT_DATE} | cut -c 7-10)
                        NextDayUnixTime=$(date -d "${NextDayRevC}-${NextDayRevB}${NextDayRevA}" +%s)


                        else
                                echo "Database not working?"
                                exit 1
                        fi


                done

else
        echo "Database not working?"
        exit 1
fi
