#!/usr/bin/env bash

set -x

mkdir -p ./JSON/

> $formatingFile

# assetName
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ assetName: { $exists: true}}, {assetName:1, _id:0}).limit(1);' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# assetType
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ assetType: { $exists: true}}, {assetType:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# assetTicker
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ assetTicker: { $exists: true}}, {assetTicker:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# mineable?
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ mineable: { $exists: true}}, {mineable:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# masternode?
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ masternode: { $exists: true}}, {masternode:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# sourceCode
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ sourceCode: { $exists: true}}, {sourceCode:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# blockTime
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ blockTime: { $exists: true}}, {blockTime:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# maxSupply
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ maxSupply: { $exists: true}}, {maxSupply:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# blockSize
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ blockSize: { $exists: true}}, {blockSize:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# walletPrefix
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ walletPrefix: { $exists: true}}, {walletPrefix:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# explorer
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ explorer: { $exists: true}}, {explorer:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# explorer2
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ explorer2: { $exists: true}}, {explorer2:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# explorer3
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ explorer3: { $exists: true}}, {explorer3:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# website
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ website: { $exists: true}}, {website:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# rpcPort
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ rpcPort: { $exists: true}}, {rpcPort:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# networkPort
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ networkPort: { $exists: true}}, {networkPort:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# bitcointalkThread
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ bitcointalkThread: { $exists: true}}, {bitcointalkThread:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# telegram
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ telegram: { $exists: true}}, {telegram:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# reddit
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ reddit: { $exists: true}}, {reddit:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# twitter
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ twitter: { $exists: true}}, {twitter:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# chat
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ chat: { $exists: true}}, {chat:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# about
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ about: { $exists: true}}, {about:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# algorithm
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ algorithm: { $exists: true}}, {algorithm:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

#  developerFee
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ developerFee: { $exists: true}}, {developerFee:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

#  whitepaper
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ whitepaper: { $exists: true}}, {whitepaper:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# firstBlock
mongo --host $mongoHost --port $mongoPort --eval 'db.basicInfo.find({ firstBlock: { $exists: true}}, {firstBlock:1, _id:0});' --quiet $database >> $formatingFile
echo $addComma >> $formatingFile

# Format JSON
sed -i 's@{@@g' $formatingFile
sed -i 's@}@@g' $formatingFile
sed -i '$ d' $formatingFile
sed -i "1i\{" $formatingFile
sed -i "\$a\}" $formatingFile
sed -i "1i\[" $formatingFile
sed -i "\$a\]" $formatingFile
sed -i '/^[[:space:]]*$/d' $formatingFile

ssh root@${websiteHost} "mkdir -p /usr/share/nginx/grepblockcom/apidata/${assetTicker}/"
scp ${formatingFile} root@${websiteHost}:/usr/share/nginx/grepblockcom/apidata/${assetTicker}/${file}
