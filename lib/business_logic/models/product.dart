// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.name,
    required this.reference,
    required this.price,
    required this.description,
    required this.quantity,
    required this.image,
  });

  String id;
  String name;
  String reference;
  int price;
  String description;
  int quantity;
  Image image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        reference: json["reference"],
        price: json["price"],
        description: json["description"],
        quantity: json["quantity"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "reference": reference,
        "price": price,
        "description": description,
        "quantity": quantity,
        "image": image.toJson(),
      };
}

class Image {
  Image({
    required this.publicId,
    required this.url,
  });

  String publicId;
  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        publicId: json["public_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
      };
}
