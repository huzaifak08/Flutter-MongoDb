import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_mongodb/Mongo%20Essentials/mongo_constants.dart';
import 'package:flutter_mongodb/Mongo%20Models/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, collection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db); // This will print some extra details on terminal.
    var status = db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
    print(await collection.find().toList()); // Print the data in collection.
  }

  static Future<String> insert(MongoModel data) async {
    try {
      var result = await collection.insertOne(data.toJson());
      if (result.isSuccess) {
        return 'Data inserted';
      } else {
        return 'Error Occoured';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
