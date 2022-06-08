import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ProductsList {
  List<Product> products;
  ProductsList({required this.products});

  factory ProductsList.fromJson (Map<String, dynamic> json) {
    print('from json productList');
    print(json);
    print(json['product']);
    var productsJson = json['products'] as List;

    print('productsJson');
    print(productsJson);
    List<Product> productsList = productsJson.map((i) => Product.fromJson(i)).toList();

    print('productsList');
    print(productsList);
    print(productsList.runtimeType);

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

// class OfficesList {
//   List<Office> offices;
//   OfficesList({required this.offices});
//
//   factory OfficesList.fromJson (Map<String, dynamic> json) {
//
//     var officesJson = json['offices'] as List;
//
//     List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();
//
//     return OfficesList(
//       offices: officesList,
//     );
//   }
// }
//
// class Office {
//   final String name;
//   final String address;
//   final String image;
//
//   Office({required this.name, required this.address, required this.image});
//
//   factory Office.fromJson(Map<String, dynamic> json) {
//     return Office(
//         name: json['name'] as String,
//         address: json['address'] as String,
//         image: json['image'] as String
//     );
//   }
// }
//
// Future<OfficesList> getOfficesList() async {
//  const url = 'https://about.google/static/data/locations.json';
//
//   final response = await http.get(Uri.parse(url));
//
//   if(response.statusCode == 200) {
//     return OfficesList.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }
//
// Future<OfficesList> readJson() async {
//   final String response = await rootBundle.loadString('assets/data.json');
//   final data = await json.decode(response);
//   return OfficesList.fromJson(json.decode(response));
//   // setState(() {
//   //   _items = data["items"];
//   // });
// }

Future<ProductsList> readJson() async {
  final String response = await rootBundle.loadString('assets/products.json');
  final data = await json.decode(response);
  return ProductsList.fromJson(json.decode(response));

}
