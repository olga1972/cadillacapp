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

class CategoriesList {
  List<Category> categories;
  CategoriesList({required this.categories});

  factory CategoriesList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json CategoriesList');
    var categoriesJson = json['categories'] as List;

    debugPrint('categoriesJson');
    debugPrint(categoriesJson.toString());
    List<Category> categoriesList = categoriesJson.map((i) => Category.fromJson(i)).toList();
    return CategoriesList(
      categories: categoriesList,
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

  // get categoryName => null;

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

class Category {
  late final String categoryId;
  late final String category;
  late final String id;

  Category({
    required this.categoryId,
    required this.category,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] as String,
      category: json['category'] as String,
      id: json['id'] as String,
    );
  }

  Future<CategoriesList> getCategoriesList() async {
    const url = 'https://cadillacapp.ru/test/categories_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body getCategoriesList');
    if (response.statusCode == 200) {
      return CategoriesList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['category'] = category;
    data['id'] = id;
    return data;
  }
}


