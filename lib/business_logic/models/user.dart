// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.phoneNumber,
      required this.url});

  String id;
  String name;
  String lastname;
  String phoneNumber;
  String url;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"],
      name: json["name"],
      lastname: json["lastname"],
      phoneNumber: json["phoneNumber"],
      url: json["url"]!);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "phoneNumber": phoneNumber,
        "url": url,
      };
}
