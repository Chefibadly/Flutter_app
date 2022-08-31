import 'dart:developer';
import '../../api_const.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  login(String phoneNumber, String password) async {
    var res = await http.post(Uri.parse('${api.apiBase}/users/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "phoneNumber": phoneNumber,
          "password": password
        }));

    //final data = json.decode(res.body);
    Map<String, dynamic> data = json.decode(res.body);

    if (data["error"] != null) {
      return data["error"];
    } else {
      return data;
    }
  }
}
