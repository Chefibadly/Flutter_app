import 'dart:convert';
import '../../api_const.dart' as api;
import 'package:http/http.dart' as http;
import 'package:mobile/business_logic/models/loyalty_card.dart';

class LoyaltyCardsRepository {
  Future<bool> deleteLoyaltyCardById({required String id}) async {
    final response = await http.delete(
        Uri.parse("${api.apiBase}/loyaltyCards/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<LoyaltyCard>> getAllLoyaltyCardsByIdUser(
      {required String id}) async {
    //print('i am in $id');
    final response = await http.get(
      Uri.parse("${api.apiBase}/loyaltyCards/owner/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> json = jsonDecode(response.body);

    List<LoyaltyCard> loyaltycards = List<LoyaltyCard>.from(
        json["loyaltyCards"].map((x) => LoyaltyCard.fromJson(x)));
    //print(loyaltycards);
    return loyaltycards;
  }

  Future<LoyaltyCard> getLoyaltyCardById({required String id}) async {
    //print('i am in $id');
    final response = await http.get(
      Uri.parse("${api.apiBase}/loyaltyCards/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var json = jsonDecode(response.body);
    print(json.toString());

    LoyaltyCard loyaltycard = LoyaltyCard.fromJson(json);

    //print(loyaltycards);
    return loyaltycard;
  }

  Future addLoyaltyCardByIdUser(
      {required String idProgram, required idUser}) async {
    final response = await http.post(
        Uri.parse("${api.apiBase}/loyaltyCards/$idUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "validationDate": "20-12-2022",
          "id_program": idProgram
        }));

    Map<String, dynamic> data = json.decode(response.body);

    if (data["error"] != null) {
      return data["error"];
    } else {
      return data;
    }
  }

  Future<bool> updateLoyaltyCardById({required LoyaltyCard loyaltyCard}) async {
    final response = await http.put(
        Uri.parse("${api.apiBase}/loyaltyCards/${loyaltyCard.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: loyaltyCardToJson(loyaltyCard));

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
