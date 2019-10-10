#!/usr/bin/env node

var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://10.10.100.201:27017";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("bitcoin");
  dbo.collection("blocks").find({"time" : { $gt: 1558847361}}).toArray(function(err, result) {
    if (err) throw err;
    console.log(result);
    db.close();
  });
}); 
