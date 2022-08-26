import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

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
  late final String categoryId;
  late final String category;
  late final String id;
  late final String productId;
  late final String productName;
  late final String productImage;
  late final dynamic productPrice;

  Product({
    required this.categoryId,
    required this.category,
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryId: json['categoryId'] as String,
      category: json['category'] as String,
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: json['productPrice'] as dynamic,
    );
  }

  Future<ProductsList> getProductsList() async {
    const url = 'https://cadillacapp.ru/test/products_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body getProductsList');
    if (response.statusCode == 200) {
      return ProductsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['category'] = category;
    data['id'] = id;
    data['productId'] = productId;
    data['productName'] = productName;
    data['productImage'] = productImage;
    data['productPrice'] = productPrice;

    return data;
  }
}


