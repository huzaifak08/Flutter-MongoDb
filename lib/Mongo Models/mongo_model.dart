import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoModel mongoModelFromJson(String str) =>
    MongoModel.fromJson(json.decode(str));

String mongoModelToJson(MongoModel data) => json.encode(data.toJson());

class MongoModel {
  ObjectId id;
  String username;
  String age;
  String email;

  MongoModel({
    required this.id,
    required this.username,
    required this.age,
    required this.email,
  });

  factory MongoModel.fromJson(Map<String, dynamic> json) => MongoModel(
        id: json["_id"],
        username: json["username"],
        age: json["age"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "age": age,
        "email": email,
      };
}
