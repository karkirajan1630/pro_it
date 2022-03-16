/* {
  "id" : "adfjjad43j234f",
  "title": "App Development",
  "imageUrl": "https://cdn.shopify.com/s/files/1/0559/9736/6449/products/WebDevelopment_1_1800x1800.png?v=1617489687",
  "price":{
      "basic": 247417.18,
      "standard": 494834.35,
      "premium": 1649447.83
  },
  "description":"We Design and Develop Experiences that Make People's lives simples."
}
*/

import 'databaseItem.dart';

class ProductV extends DatabaseItem {
  final String id;
  final int views;

  ProductV({required this.id,required  this.views}):super(id);
  factory ProductV.fromMap(String id, Map<String, dynamic> json) => ProductV(
        id: id,
        views: json["views"],
      );

  Map<String, dynamic> toMap() => {
        "views": views,
      };
}

class Product extends DatabaseItem {
  Product({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  }) : super(id);

  final String? id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  factory Product.fromMap(String id, Map<String, dynamic> json) => Product(
        id: id,
        title: json["title"],
        imageUrl: json["imageUrl"],
        price: json["price"].toDouble(),
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "imageUrl": imageUrl,
        "price": price,
        "description": description,
      };
}


