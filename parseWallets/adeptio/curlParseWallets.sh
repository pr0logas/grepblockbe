#!/usr/bin/env bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

function databaseAlive() {
        mongo --host $mongoHost --port $mongoPort --eval 'db.getMongo().getDBNames()' --quiet $database > /dev/null
        if [ $? = 0 ]; then
            echo "Database working, OK" > /dev/null
        else
                echo ""
                echo "FATAL! Database not working?"
            echo ""
            exit 1
        fi
}

function startCountingProcessTime1() {
        start1=$(($(date +%s%N)/1000000))
}

function startCountingProcessTime2() {
        start2=$(($(date +%s%N)/1000000))
}

function startCountingProcessTime3() {
        start3=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime1() {
        end1=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime2() {
        end2=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime3() {
        end3=$(($(date +%s%N)/1000000))
}

function checkLastBlockInDB() {
    mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {block:1, _id:0}).limit(1).sort({$natural: -1}).limit(1);' --quiet $database | grep -o '[0-9]*'
}

# Check if we have a collection created
check=$(mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).sort({$natural: -1});' --quiet $database | jq -r '.lastblock')
        if [[ $check < 0 ]] ; then
                mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.insert({"lastblock" : 0});' --quiet $database
        else
                echo "ALL good"
        fi

        checkLastProgress=$(mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).sort({$natural: -1});' --quiet $database | jq -r '.lastblock')

	if [[ $checkLastProgress -eq 0 ]]; then
		tempReduce=$(($checkLastProgress+0))
	else
        	tempReduce=$(($checkLastProgress-1))
	fi

# Decrease block in MongoDB in case of previuos failure
mongo --host $mongoHost --port $mongoPort --eval "db.txidsProgress.update({\"lastblock\" : $checkLastProgress},{\$set : {\"lastblock\" : $tempReduce}});" $database --quiet &> /dev/null

lastBlockInDB=$(checkLastBlockInDB)

# :: Starting infinte loop to sync up to date ::
for (( ; ; ))
        do

        # Database alive?
        databaseAlive

        startCountingProcessTime1
        checkLastProgress=$(mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).sort({$natural: -1});' --quiet $database | grep -o '[0-9]*')

        checkLastProgressIncreased=$(echo "$checkLastProgress + 1" | bc)


        if [[ $checkLastProgressIncreased -eq  $lastBlockInDB ]]; then
            echo "$setDateStamp Processing: no new txids with a block: $checkLastProgressIncreased Sleeping for $blockTime s"
            exit 0
        else
            echo "All good, still not latest block" > /dev/null
        fi


        # Search TXids in required block
        mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $checkLastProgressIncreased}, {tx:1, _id:0});" --quiet $database | jq -r '.tx' | jq '.[]' > $dataFileWallets

        sed -i 's@"@@g' $dataFileWallets

        IFS=$'\n'
        for i in $(cat $dataFileWallets)
                do

                        # Get txid data from RPC
			startCountingProcessTime2
                            curl -m 10 -s ${chainProvider}${getTx}${i}\&decrypt\=1 | jq '' > $dataFileWallets2
                            cat $dataFileWallets2 | grep "txid" > /dev/null
                            if [[ $? = 1 ]]; then
                                echo ""
                                echo "$setDateStamp Up-to-date. No new transactions found? Last checked block was: $checkLastProgressIncreased."
                                echo ""
                                exit 0
                            else
                                echo "" > /dev/null
                            fi

                # Check if RPC responded with hash value // 0 - OK // 5 - No new txids // Other - ERROR
                if [ $? -eq 0 ]; then

                        IFS=$'\n'
                        for y in $(cat $dataFileWallets2 | awk '/addresses/,/]/' | sed 's@"addresses":@@'g | sed 's@\[@@g' | sed 's@]@@g' | sed 's@}@@g'| sed 's@{@@g' | sed 's@,@@g' | sed 's@"@@g' | sed "s@ @@g" | sed '/^\s*$/d' | uniq)
                            do
                            startCountingProcessTime3
                            walletTime=$(cat $dataFileWallets2 | grep blocktime | grep -o '[0-9]*')

                            echo "{" > $dataFileWallets3
                            echo "\"block\" : ${checkLastProgressIncreased}," >> $dataFileWallets3
                            echo "\"walletTime\" : ${walletTime}," >> $dataFileWallets3
                            echo "\"wallet\" : \"$y\"" >> $dataFileWallets3
                            echo "}" >> $dataFileWallets3

                            mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionWallets --file $dataFileWallets3 --mode upsert --upsertFields wallet --quiet &> /dev/null

                            # Check if no ERROR occured
                            if [ $? -eq 0 ]; then
                                    
                                    
                                     stopCountingProcessTime3
                                     runtime3=$((end3-start3))
                                     setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                     echo "$setDateStamp Processing wallet: $y $runtime3 ms"

                            else
                                    echo "$setDateStamp Processing: txid: $i at block: $checkLastProgressIncreased FAILED"
				    exit 1
                            fi
                        done
                                     stopCountingProcessTime2
                                     runtime2=$((end2-start2))
                                     setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                     echo -e "${BLUE}$setDateStamp Txid aggregation done: $i $runtime2 ms ${NC}"


                elif [ $? -eq 5 ]; then
                        echo "$setDateStamp Processing: no new txids with a block: $checkLastProgressIncreased Sleeping for $blockTime s"
                        sleep $blockTime
                else
                        setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                        echo "$setDateStamp Fatal ERROR occured, unsuported response from RPC"
                fi
        done
                                    # Increase finished block in MongoDB
                                    mongo --host $mongoHost --port $mongoPort --eval "db.txidsProgress.update({\"lastblock\" : $checkLastProgress},{\$set : {\"lastblock\" : $checkLastProgressIncreased}});" $database --quiet &> /dev/null
                                    stopCountingProcessTime1
                                    runtime1=$((end1-start1))
                                    setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                                    ConvertUnixTime="$(date -d @${walletTime} +'%Y-%m-%d')"
                                    echo -e "${GREEN}$setDateStamp Block aggregation finished: block: $checkLastProgressIncreased at $ConvertUnixTime. Overall processing took: $runtime1 ms ${NC}"
done

