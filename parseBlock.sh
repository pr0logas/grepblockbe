#!/usr/bin/env bash

# Set Functions;
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

function getHash() {
        $daemonCli -rpcconnect=$rpcconnect -rpcport=$rpcport -rpcuser=$rpcuser -rpcpassword=$rpcpassword getblockhash $1

}

function checkDBstatus() {
        mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {block:1, _id:0}).sort({$natural: -1}).limit(1);' --quiet $database | grep -o '[0-9]*'
}

function insertZeroBlock() {
        mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.insert({"block" : 0});' --quiet $database
}

function checkLastBlockInDB() {
        mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {block:1, _id:0}).limit(1).sort({$natural: -1}).limit(1);' --quiet $database | grep -o '[0-9]*'
}

function askRPCblockHash() {
        $daemonCli -rpcconnect=$rpcconnect -rpcport=$rpcport -rpcuser=$rpcuser -rpcpassword=$rpcpassword getblock $1 > $dataFileBlocks
}

function insertBlockNumInTMPfile() {
        sed -i "2i\ \ \"block\": $1\," $dataFileBlocks
}

function writeDataToDatabase() {
        mongoimport --host $mongoHost --port $mongoPort --db $database --collection $collectionBlocks --file $dataFileBlocks --mode upsert --upsertFields block --quiet

        # Check if no ERROR occured
        if [ $? -eq 0 ]; then

                setTimeStamp
            stopCountingProcessTime
                runtime=$((end-start))
            echo "$setDateStamp Processing block: $lastBlockInDB. Processing took: $runtime ms" 

        else
            echo "$setDateStamp Process block: $lastBlockInDB FAILED"
            exit 1
        fi
}

function setTimeStamp() {
        setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
}

function startCountingProcessTime() {
        start=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime() {
        end=$(($(date +%s%N)/1000000))
}

# PreCheck does DB works?
databaseAlive

# PreStart check if we have a collection created in MongoDB?
check=$(checkDBstatus)
        if [[ "$check" < 0 ]] ; then
                insertZeroBlock
        echo "No data in database. Warning! Starting from zero..."

    else
        echo "Found data in database. All Good. Continuing progress and appending only new data..."

    fi

# Check last block in MongoDB
lastBlockInDB=$(checkLastBlockInDB)

# Sync blocks in range for +?
syncXBlocks=$(($lastBlockInDB+${parseBlocksInRangeFor}))

# Start for loop from last block in DB
for (( i=${lastBlockInDB}; i<=${syncXBlocks}; i++ ))

        do

        # Database alive?
        databaseAlive

        # Start counting processing time
        startCountingProcessTime

        # Increase block number by + 1 in order to continue progress.
        lastBlockInDB=$(($lastBlockInDB+1))

        # Get block hash value from daemon RPC
        getBlockHash=$(getHash "${lastBlockInDB}")

        # Check if RPC responded with hash value // 0 - OK // 8 - No new blocks // Other - ERROR
        if [ $? -eq 0 ]; then

                # Send blockhash to RPC // Get FULL block data // write data to TMP file
                askRPCblockHash "${getBlockHash}"

                # Insert block number in TMP file
                insertBlockNumInTMPfile "${lastBlockInDB}"

                # Writing block data to MongoDB
                writeDataToDatabase

        elif [ $? -eq 1 ]; then

                getHash "${lastBlockInDB}"

                    if [ $? -ne 8 ]; then

                        echo "FATAL! Does daemon working?"
                        exit 1

                    else

                                setTimeStamp
                                echo "$setDateStamp Up-to-date. No new blocks found. Last checked block was: $lastBlockInDB."
                                exit 0

                    fi

        else

                # Unexpected output code // Unresolvable error occured
                setTimeStamp
                echo "** $setDateStamp Unexpected ERROR occured, failed to get blockhash value. Tried to get block: $lastBlockInDB **"
                exit 1
        fi
done
