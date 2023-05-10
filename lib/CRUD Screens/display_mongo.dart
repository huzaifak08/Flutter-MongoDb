import 'package:flutter/material.dart';
import 'package:flutter_mongodb/CRUD%20Screens/insert_mongo.dart';
import 'package:flutter_mongodb/Mongo%20Essentials/mongo_db.dart';
import 'package:flutter_mongodb/Mongo%20Models/mongo_model.dart';

class DisplayMongoDb extends StatefulWidget {
  const DisplayMongoDb({super.key});

  @override
  State<DisplayMongoDb> createState() => _DisplayMongoDbState();
}

class _DisplayMongoDbState extends State<DisplayMongoDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display MongoDB'),
      ),
      body: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var totalData = snapshot.data.length;
            debugPrint('Total Data: $totalData');

            return Column(
              children: [
                // Total Data:
                ListTile(
                  title: Text('Total Data: ${totalData}'),
                ),

                // Get Data:
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          MongoModel.fromJson(snapshot.data[index]));
                    },
                  ),
                )
              ],
            );
          } else {
            return const Center(child: Text('No Data Avaialable'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InsertMongoDb()));
        },
      ),
    );
  }

  Widget displayCard(MongoModel data) {
    return Row(
      children: [
        Column(
          children: [
            Text('id: ${data.id}'),
            Text('name: ${data.username}'),
            Text('email: ${data.email}'),
            Text('age: ${data.age}'),
            const SizedBox(height: 20),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InsertMongoDb(),
                          settings: RouteSettings(arguments: data)))
                  .then((value) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () async {
              print(data.id);
              await MongoDatabase.delete(data);
              setState(() {});
            },
            icon: const Icon(Icons.delete))
      ],
    );
  }
}
