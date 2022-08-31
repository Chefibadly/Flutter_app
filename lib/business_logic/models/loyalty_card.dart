// To parse this JSON data, do
//
//     final loyaltyCard = loyaltyCardFromJson(jsonString);

import 'dart:convert';

LoyaltyCard loyaltyCardFromJson(String str) =>
    LoyaltyCard.fromJson(json.decode(str));

String loyaltyCardToJson(LoyaltyCard data) => json.encode(data.toJson());

class LoyaltyCard {
  LoyaltyCard({
    required this.id,
    required this.points,
    required this.checkPoints,
    required this.reached,
    required this.rewards,
    required this.validationDate,
    required this.title,
    required this.description,
    required this.idClient,
    required this.idProgram,
  });

  String id;
  int points;
  int checkPoints;
  int reached;
  List<dynamic> rewards;
  String validationDate;
  String title;
  String description;
  String idClient;
  String idProgram;

  factory LoyaltyCard.fromJson(Map<String, dynamic> json) => LoyaltyCard(
        id: json["_id"],
        points: json["points"],
        checkPoints: json["checkPoints"],
        reached: json["reached"],
        rewards: List<dynamic>.from(json["rewards"].map((x) => x)),
        validationDate: json["validationDate"],
        title: json["title"],
        description: json["description"],
        idClient: json["id_client"],
        idProgram: json["id_program"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "points": points,
        "checkPoints": checkPoints,
        "reached": reached,
        "rewards": List<dynamic>.from(rewards.map((x) => x)),
        "validationDate": validationDate,
        "title": title,
        "description": description,
        "id_client": idClient,
        "id_program": idProgram,
      };
}
