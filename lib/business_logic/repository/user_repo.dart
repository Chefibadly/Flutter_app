import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../../api_const.dart' as api;

import 'package:mobile/business_logic/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class UserRepository {
  Future<User> getUser({required String id}) async {
    final response = await http.get(
      Uri.parse("${api.apiBase}/users/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //Map<String, dynamic> json = jsonDecode(response.body.toString());

    User user = userFromJson(response.body.toString());
    print('hereeeeee:...${user.toString()}');
    return user;
  }

  getUserWallet({required String id}) async {
    final response = await http.get(
      Uri.parse("${api.apiBase}/users/getWallet/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //Map<String, dynamic> json = jsonDecode(response.body.toString());

    List<dynamic> wallet = jsonDecode(response.body.toString());
    print('hereeeeee:...${wallet.toString()}');
    return wallet;
  }

  Future<bool> updateUser({required String id, required String url}) async {
    final response = await http.put(
      Uri.parse("${api.apiBase}/users/$id"),
      body: jsonEncode(<String, String>{"url": url}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //Map<String, dynamic> json = jsonDecode(response.body.toString());

    return response.statusCode == 200 ? true : false;
  }

  Future<bool> updateWallet({required String id, required int amount}) async {
    final response = await http.put(
      Uri.parse("${api.apiBase}/users/updateWallet/$id"),
      body: jsonEncode(<String, int>{"balance": amount}),
      headers: <String, String>{},
    );

    //Map<String, dynamic> json = jsonDecode(response.body.toString());
    print('status codeee ' + response.statusCode.toString());
    return response.statusCode == 200 ? true : false;
  }

  Future<StreamedResponse> upload(File imageFile) async {
    String result;
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("${api.apiBase}/upload");

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', 'png'));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();

    /* response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      result = value;
    }); */

    return response;
  }
}
