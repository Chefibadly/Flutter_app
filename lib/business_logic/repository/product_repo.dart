import 'package:mobile/business_logic/models/product.dart';

import '../../api_const.dart' as api;

import 'package:http/http.dart' as http;

class ProductRepository {
  Future<Product> getProduct({required String id}) async {
    final response = await http.get(
      Uri.parse("${api.apiBase}/products/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //Map<String, dynamic> json = jsonDecode(response.body.toString());

    Product product = productFromJson(response.body.toString());
    print('hereeeeee:...${product.toString()}');
    return product;
  }
}
