import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mongodb/Mongo%20Essentials/mongo_db.dart';
import 'package:flutter_mongodb/Mongo%20Models/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class InsertMongoDb extends StatefulWidget {
  const InsertMongoDb({super.key});

  @override
  State<InsertMongoDb> createState() => _InsertMongoDbState();
}

class _InsertMongoDbState extends State<InsertMongoDb> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  var _checkInsertUpdate = 'Insert';

  @override
  Widget build(BuildContext context) {
    MongoModel data = ModalRoute.of(context)?.settings.arguments as MongoModel;

    if (data != null) {
      nameController.text = data.username;
      ageController.text = data.age;
      emailController.text = data.email;

      _checkInsertUpdate = 'Update';
    }

    return Scaffold(
      appBar: AppBar(title: Text(_checkInsertUpdate)),
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
                      if (_checkInsertUpdate == 'Update') {
                        _updateData(data.id, nameController.text,
                            ageController.text, emailController.text);
                      } else {
                        _insertData(nameController.text, ageController.text,
                            emailController.text);

                        Navigator.pop(context);
                      }
                    },
                    child: Text(_checkInsertUpdate)),
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

  Future<void> _updateData(
      var id, String name, String age, String email) async {
    final updateData =
        MongoModel(id: id, username: name, age: age, email: email);

    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
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
