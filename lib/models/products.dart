import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class ProductsList {
  List<Product> products;
  ProductsList({required this.products});

  factory ProductsList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json productList');
    var productsJson = json['products'] as List;

    debugPrint('productsJson');
    debugPrint(productsJson.toString());
    List<Product> productsList = productsJson.map((i) => Product.fromJson(i)).toList();
    return ProductsList(
      products: productsList,
    );
  }
}

class Product {
  late final int categoryId;
  late final String category;
  late final int id;
  late final String name;
  late final String image;
  late final dynamic price;
  late final int quantity;

  Product({
    required this.categoryId,
    required this.category,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryId: json['categoryId'] as int,
      category: json['category'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: json['price'] as dynamic,
      quantity: json['quantity'] as int,
    );
  }
}

Future<ProductsList> readJson() async {
  final String response = await rootBundle.loadString('assets/products.json');
  return ProductsList.fromJson(json.decode(response));
}
