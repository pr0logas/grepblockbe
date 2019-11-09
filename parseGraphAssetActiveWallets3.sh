#!/usr/bin/env bash

# :: Create JSON directory if it's not exist ::
mkdir -p ./JSON/

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

function setTimeStamp() {
        setDateStamp=$(date +%Y-%m-%d\|%H:%M:%S\|%N)
}

function startCountingProcessTime() {
        start=$(($(date +%s%N)/1000000))
}

function stopCountingProcessTime() {
        end=$(($(date +%s%N)/1000000))
}

function checkLastBlockInDB() {
    mongo --host $mongoHost --port $mongoPort --eval 'db.blocks.find({}, {block:1, _id:0}).limit(1).sort({$natural: -1}).limit(1);' --quiet $database | grep -o '[0-9]*'
}

function checkLastBlockInDBtxidProgress() {
    mongo --host $mongoHost --port $mongoPort --eval 'db.txidsProgress.find({}, {lastblock:1, _id:0}).limit(1).sort({$natural: -1}).limit(1);' --quiet $database | grep -o '[0-9]*'
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
        echo " \"name\" : \"ActiveWallets\"" >> $formatingFile
        echo $addComma >> $formatingFile
        echo " \"unit\" : \"ActiveWallets\"" >> $formatingFile
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

# Are we up to date?
lastBlock=$(checkLastBlockInDB)
checkLastBlocktxidProgres=$(checkLastBlockInDBtxidProgress)
diff=$(echo "$lastBlock - $checkLastBlocktxidProgres" | bc)

if [[ $diff -gt 10 ]] || [[ $diff -lt 0 ]]; then
    echo "We are not up to date with blocks collection! Diff $diff"
    exit 0
else 
    echo "All good" > /dev/null
fi

for (( ; ; ))
        do
    # Check if DB works
    databaseAlive
	startCountingProcessTime
    # Check last progress
    lastProgress=$(tail -n10 $formatingFile  | grep x | grep -o '[0-9]*')
	
	averageBlkMinus=$(echo "86400 - $blockTime" | bc)	

	lastProgress=$(echo "$lastProgress + $averageBlkMinus" | bc) 

        # LastProgress Time in DB
        lastProgressInDB1=$(mongo --host $mongoHost --port $mongoPort --eval "db.blocks.find({\"time\" : { \$gt: \"$lastProgress\"}}).sort({\$natural: 1}).limit(1)" --quiet $database | grep -o -P '."time".{0,16}' | head -1 | grep -o '[0-9]*')

	if [ -z "$lastProgressInDB1" ]; then
		setTimeStamp
      	echo "$setDateStamp No new info on database. We at $ConvertUnixTime. Sleeping..."
		echo ""
		exit 0
	else
      		echo "" > /dev/null
	fi

        # Search only < 3 month older activeWallet count;
        searchActiveWltMinus3mos=$(($lastProgressInDB1 - 7776000))

        currentWalletsMinus3mos=$(mongo --host $mongoHost --port $mongoPort --eval "db.wallets.find({\"walletTime\" : { \$lt : $searchActiveWltMinus3mos}}).count()" --quiet $database | grep -o '[0-9,.-.]*')
        searchingForActiveWlt=$(mongo --host $mongoHost --port $mongoPort --eval "db.wallets.find({\"walletTime\" : { \$lt : $lastProgress}}).count()" --quiet $database | grep -o '[0-9,.-.]*')
        result=$(($searchingForActiveWlt - $currentWalletsMinus3mos))

                                # Format JSON
                                sed -i '$ d' $formatingFile
                                sed -i '$ d' $formatingFile
                                echo $addComma >> $formatingFile

                                echo $addCurlyBracketsStart >> $formatingFile
                                echo " \"x\" : ${lastProgressInDB1}" >> $formatingFile
                                echo $addComma >> $formatingFile
                                echo " \"y\" : ${result}" >> $formatingFile
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
		echo "$setDateStamp ActiveWallets: ${result} we at $ConvertUnixTime now. Processing: $runtime ms."

                # Copy JSON to production
                scp ${formatingFile} root@${websiteHost}:/usr/share/nginx/grepblockcom/apidata/${assetTicker}/${file}
done

