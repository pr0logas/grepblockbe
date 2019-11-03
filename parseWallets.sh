#!/usr/bin/env bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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


# :: Starting infinte loop to sync up to date ::
for (( ; ; ))
        do

        startCountingProcessTime1
        checkLastProgress=$(mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).sort({$natural: -1});' --quiet $database | jq -r '.lastblock')

        checkLastProgressIncreased=$(($checkLastProgress+1))

        # Search TXids in required block
        mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $checkLastProgressIncreased}, {tx:1, _id:0});" --quiet $database | jq -r '.tx' | jq '.[]' > $dataFileWallets

        sed -i 's@"@@g' $dataFileWallets

        IFS=$'\n'
        for i in $(cat $dataFileWallets)
                do
                        startCountingProcessTime2
                        # Get txid data from RPC
                        $daemonCli -rpcconnect=$rpcconnect -rpcport=$rpcport -rpcuser=$rpcuser -rpcpassword=$rpcpassword getrawtransaction $i 1 > $dataFileWallets2

                # Check if RPC responded with hash value // 0 - OK // 5 - No new txids // Other - ERROR
                if [ $? -eq 0 ]; then

                        IFS=$'\n'
                        for y in $(cat $dataFileWallets2 | awk '/addresses/,/]/' | sed 's@"addresses":@@'g | sed 's@\[@@g' | sed 's@]@@g' | sed 's@}@@g'| sed 's@{@@g' | sed 's@,@@g' | sed 's@"@@g' | sed "s@ @@g" | sed '/^\s*$/d' | sed 's@bitcoincash:@@g' | uniq)
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
