import 'dart:developer';

import 'package:flutter_mongodb/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db); // This will print some extra details on terminal.
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);

    // Insert or create data:
    await collection.insertOne({
      "username": "huzaifak08",
      "age": "22",
      "email": "hk7928042@gmail.com"
    });

    // Insert many Objects:
    await collection.insertMany([
      {"username": "hanzlak08", "age": "15", "email": "hanzla@gmail.com"},
      {"username": "hanzla2k08", "age": "14", "email": "hanzla2@gmail.com"}
    ]);

    // Update:
    await collection.update(
        where.eq('username', 'hanzla2k08'), modify.set('username', 'hamza08'));

    print(await collection.find().toList()); // Print the data in collection.
  }
}
