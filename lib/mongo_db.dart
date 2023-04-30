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
    print(await collection.find().toList());
  }
}
