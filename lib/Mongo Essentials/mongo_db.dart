import 'dart:developer';

import 'package:flutter_mongodb/Mongo%20Essentials/mongo_constants.dart';
import 'package:flutter_mongodb/Mongo%20Models/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, collection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open(secure: true);
    inspect(db); // This will print some extra details on terminal.
    var status = db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
    print(await collection.find().toList()); // Print the data in collection.
  }

  // Insert Data in MongoDB:
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

  // Display Data in MongoDB:
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await collection.find().toList();
    return arrData;
  }

  // Update Data in MongoDB:
  static Future<void> update(MongoModel data) async {
    var result = await collection.findOne({'_id': data.id});
    result['username'] = data.username;
    result['age'] = data.age;
    result['email'] = data.email;
    var response = await collection.save(result);
    inspect(response);
  }

  // Delete Data in MongoDB:
  static delete(MongoModel user) async {
    await collection.remove(where.id(user.id));
  }
}
