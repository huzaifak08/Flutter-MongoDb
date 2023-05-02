import 'package:flutter/material.dart';
import 'package:flutter_mongodb/CRUD%20Screens/insert_mongo.dart';

import 'Mongo Essentials/mongo_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MongoDbInsert(),
    );
  }
}
