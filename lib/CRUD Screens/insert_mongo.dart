import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mongodb/Mongo%20Essentials/mongo_db.dart';
import 'package:flutter_mongodb/Mongo%20Models/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inser in MongoDb')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      _fakeData();
                    },
                    child: const Text('Generate Data')),
                ElevatedButton(
                    onPressed: () {
                      _insertData(nameController.text, ageController.text,
                          emailController.text);
                    },
                    child: const Text('Insert Data')),
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<void> _insertData(String username, String age, String email) async {
    var _id = M.ObjectId(); // Generate unique id
    final data =
        MongoModel(id: _id, username: username, age: age, email: email);

    var result = await MongoDatabase.insert(data);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Inserted Id ${_id.$oid}')));

    _clearAll();
  }

  void _clearAll() {
    nameController.text = '';
    ageController.text = '';
    emailController.text = '';
  }

  void _fakeData() {
    nameController.text = faker.person.name();
    ageController.text = faker.currency.name();
    emailController.text = faker.phoneNumber.us();
  }
}
