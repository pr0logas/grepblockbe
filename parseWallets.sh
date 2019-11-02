#!/usr/bin/env bash

function startCountingProcessTime() {
        start=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime() {
        end=$(($(date +%s%N)/1000000))
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

        checkLastProgress=$(mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).sort({$natural: -1});' --quiet $database | jq -r '.lastblock')

        checkLastProgressIncreased=$(($checkLastProgress+1))

        # Search TXids in required block
        mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"block\" : $checkLastProgressIncreased}, {tx:1, _id:0});" --quiet $database | jq -r '.tx' | jq '.[]' > $dataFileWallets

        sed -i 's@"@@g' $dataFileWallets

        IFS=$'\n'
        for i in $(cat $dataFileWallets)
                do
                        
                        # Get txid data from RPC
                        $daemonCli -rpcconnect=$rpcconnect -rpcport=$rpcport -rpcuser=$rpcuser -rpcpassword=$rpcpassword getrawtransaction $i 1 > $dataFileWallets2

                # Check if RPC responded with hash value // 0 - OK // 5 - No new txids // Other - ERROR
                if [ $? -eq 0 ]; then

                        IFS=$'\n'
                        for y in $(cat $dataFileWallets2 | awk '/addresses/,/]/' | sed 's@"addresses":@@'g | sed 's@\[@@g' | sed 's@]@@g' | sed 's@}@@g'| sed 's@{@@g' | sed 's@,@@g' | sed 's@"@@g' | sed "s@ @@g" | sed '/^\s*$/d' | sed 's@bitcoincash:@@g' | uniq)
                            do
                            startCountingProcessTime
                            walletTime=$(cat $dataFileWallets2 | grep blocktime | grep -o '[0-9]*')

                            echo "{" > $dataFileWallets3
                            echo "\"block\" : ${checkLastProgressIncreased}," >> $dataFileWallets3
                            echo "\"walletTime\" : ${walletTime}," >> $dataFileWallets3
                            echo "\"wallet\" : \"$y\"" >> $dataFileWallets3
                            echo "}" >> $dataFileWallets3

                            setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)

                            mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionWallets --file $dataFileWallets3 --mode upsert --upsertFields wallet --quiet &> /dev/null


                            # Check if no ERROR occured
                            if [ $? -eq 0 ]; then
                                    stopCountingProcessTime
                                    runtime=$((end-start))
                                    echo "$setDateStamp Processing: at block: $checkLastProgressIncreased & wallet: $y Processing: $runtime ms"

                            else
                                    echo "$setDateStamp Processing: txid: $i at block: $checkLastProgressIncreased FAILED"
				    exit 1
                            fi
                        done

                                    # Increase finished block in MongoDB
                                    mongo --host $mongoHost --port $mongoPort --eval "db.txidsProgress.update({\"lastblock\" : $checkLastProgress},{\$set : {\"lastblock\" : $checkLastProgressIncreased}});" $database --quiet &> /dev/null

                elif [ $? -eq 5 ]; then
                        echo "$setDateStamp Processing: no new txids with a block: $checkLastProgressIncreased Sleeping for $blockTime s"
                        sleep $blockTime
                else
                        setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
                        echo "$setDateStamp Fatal ERROR occured, unsuported response from RPC"
                fi
        done
done
