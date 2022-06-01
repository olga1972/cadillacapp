import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class UsersList {
  List<User>? users;
  UsersList({required this.users});

  factory UsersList.fromJson (Map<String, dynamic> json) {
    // if (json['users'] != null) {
      var usersJson = json['users'] as List;
      List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();

      return UsersList(
        users: usersList,
      );
    //}

    // users = <Users>[];
    // json['users'].forEach((v) {
    //   users!.add(new Users.fromJson(v));
    // });
  }
}

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.users != null) {
//     data['users'] = this.users!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
//}


class User {
  late final String userId;
  late final String phone;
  late final String email;
  late final String username;
  late final String birthday;

  User({
    required this.userId,
    required this.phone,
    required this.email,
    required this.username,
    required this.birthday
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      birthday: json['birthday'] as String,
    );

  }

  Future<UsersList> getUsersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    const url = 'http://localhost/test/users_list.php';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      return UsersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['birthday'] = this.birthday;
    return data;
  }
}





// import 'dart:convert';
//
// // import 'package:cadillac/models/user2.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
//
// import '../env.dart';
//
// class UsersList {
//   List<User> users;
//   UsersList({required this.users});
//
//   factory UsersList.fromJson (Map<String, dynamic> json) {
//     // var usersJson = json as List;
//     var usersJson = json['users'] as List;
//
//     List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();
// print('usersList class UsersList');
// print(usersList);
//     return UsersList(
//
//       users: usersList,
//     );
//   }
// }
//
// class User {
//   String? userId;
//   String? email;
//   String? phone;
//   String? login;
//   String? password;
//   // Photo? photo;
//   String? username;
//   String? birthday;
//   String? phone2;
//   // String? car;
//   // String? address;
//
//   User({
//         this.userId,
//         this.email,
//         this.phone,
//         this.login,
//         this.password,
//         // this.photo,
//         this.username,
//         this.birthday,
//         this.phone2,
//         // this.car,
//         // this.address,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//     userId: json['userId'] as String,
//     email: json['email'] as String,
//     phone: json['phone'] as String,
//     login: json['login'] as String,
//     password: json['password'] as String,
//     // photo: json['photo'] != null ? new Photo.fromJson(json['photo']) : null,
//     username: json['username'] as String,
//     birthday: json['birthday'] as String,
//     phone2: json['phone2'] as String,
//     // car: json['car'] as String,
//     //address: json['address'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['login'] = this.login;
//     data['password'] = this.password;
//     // if (this.photo != null) {
//     //   data['photo'] = this.photo!.toJson();
//     // }
//     data['username'] = this.username;
//     data['birthday'] = this.birthday;
//     data['phone2'] = this.phone2;
//     // data['car'] = this.car;
//     //data['address'] = this.address;
//     return data;
//   }
// }
//
// // class Photo {
// //   String? photo1;
// //   String? photo2;
// //   String? photo3;
// //
// //
// //   Photo({this.photo1, this.photo2, this.photo3});
// //
// //   Photo.fromJson(Map<String, dynamic> json) {
// //     photo1 = json['photo1'];
// //     photo2 = json['photo2'];
// //     photo3 = json['photo3'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['photo1'] = this.photo1;
// //     data['photo2'] = this.photo2;
// //     data['photo3'] = this.photo2;
// //     return data;
// //   }
// // }
//
// Future<User> readJsonUser() async {
//   String apiurl = "http://localhost/test/create.php";
//
//   final String response = (await http.post(Uri.parse(apiurl),headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
//     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"})) as String;
//   final data = await json.decode(response);
//   return User.fromJson(json.decode(response));
//
// }
//
// // class User {
// //
// //   late dynamic userId;
// //   late dynamic name;
// //   late dynamic login;
// //   late dynamic birthday;
// //   late dynamic email;
// //   late dynamic password;
// //   late dynamic phone;
// //   late dynamic type;
// //   late dynamic car;
// //   late final dynamic token;
// //   late final dynamic renewalToken;
// //   late final dynamic photo;
// //   late final dynamic cars;
// //
// //   User({
// //     this.userId = '1',
// //     this.name,
// //     this.login = 'ivan@mail.ru"',
// //     this.birthday = '19.04.1972',
// //     this.email = 'ivan@mail.ru"',
// //     this.phone = '123456789',
// //     this.password = '123',
// //     this.type = 'text',
// //     this.car = 'cadillac',
// //     this.token = '123',
// //     this.renewalToken = '123456',
// //     this.photo = 'assets/images/avatar.png',
// //     this.cars = const [ 'assets/images/cadillac-eldorado.png',
// //       "assets/images/cadillac-escalada.png",
// //       "assets/images/cadillac-orange.png",
// //     ],
// //   });
// //
// //   factory User.fromJson(Map<String, dynamic> responseData) {
// //     return User(
// //       userId: responseData['userId'],
// //       name: responseData['name'],
// //       login: responseData['login'],
// //       birthday: responseData['birthday'],
// //       email: responseData['email'],
// //       phone: responseData['phone'],
// //       password: responseData['password'],
// //       type: responseData['type'],
// //       token: responseData['access_token'],
// //       renewalToken: responseData['renewal_token'],
// //       photo: responseData['photo'],
// //       cars: responseData['cars'],
// //     );
// //   }
// //
// // }
// //
// // Future<UsersList> getUsersList() async {
// //   var url = "http://localhost/test/users_list.php";
// //   // var url = 'https://json.flutter.su/echo';
// //   var headers;
// //   var config = {
// //     headers: {
// //       "Access-Control-Allow-Origin": "*",
// //       "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
// //     }
// //   };
// //   final response = await http.get(Uri.parse(url), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
// // "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
// //   print('response users');
// //
// //   print(response.body);
// //   print(response.statusCode);
// //
// //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
// //   List<UsersList> users = items.map<User>((json) {
// //     print('json');
// //     print(json);
// //     // print(User.fromJson(json));
// //     return User.fromJson(json);
// //     //return User;
// //   }).toList();
// //
// //
// //   print(UsersList.fromJson(json.decode(response.body)));
// //
// //   if (response.statusCode == 200) {
// //     print('users status code');
// //     print(response.statusCode);
// //     print(json.decode(response.body));
// //     //return json.decode(response.body);
// //     return UsersList.fromJson(json.decode(response.body));
// //
// //
// //   } else {
// //     throw Exception('Error: ${response.reasonPhrase}');
// //   }
// // }
//
// // Future<UsersList> getUsersList() async {
// //   const url = 'https://about.google/static/data/locations.json';
// //   var headers;
// //   var config = {
// //     headers: {
// //       "Access-Control-Allow-Origin": "*",
// //       "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
// //     }
// //   };
// // //const url = "${Env.URL_PREFIX}/list.php";
// //   //const url = "http://192.168.31.213/users_list.php";
// //   //192.168.31.213
// //   //http://127.0.0.1
// //   //final response = await http.get(Uri.parse(url));
// //
// //   // var response = await http.post(Uri.parse('https://json.flutter.su/echo'),
// //   //     headers: {'Accept':'application/json','Authorization':'Basic YWxhZGRpbjpvcGVuc2VzYW1l')}
// //   // );
// //   // var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'),
// //   //     headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
// //   //     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}
// //   // );
// //   var response = await http.get(Uri.parse('http://192.168.31.213/users'),
// //       headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
// //         "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}
// //   );
// //
// //   print(UsersList.fromJson(json.decode(response.body)));
// //
// //   if (response.statusCode == 200) {
// //
// //     return UsersList.fromJson(json.decode(response.body));
// //   } else {
// //     throw Exception('Error: ${response.reasonPhrase}');
// //   }
// // }
//
// // class Product {
// //   late final int categoryId;
// //   late final String category;
// //   late final int id;
// //   late final String name;
// //   late final String image;
// //   late final dynamic price;
// //   late final int quantity;
// //
// //   Product({
// //     required this.categoryId,
// //     required this.category,
// //     required this.id,
// //     required this.name,
// //     required this.image,
// //     required this.price,
// //     required this.quantity,
// //   });
// //
// //   factory Product.fromJson(Map<String, dynamic> json) {
// //     return Product(
// //         categoryId: json['categoryId'] as int,
// //         category: json['category'] as String,
// //         id: json['id'] as int,
// //         name: json['name'] as String,
// //         image: json['image'] as String,
// //         price: json['price'] as dynamic,
// //         quantity: json['quantity'] as int,
// //     );
// //   }
// // }
//
// // class OfficesList {
// //   List<Office> offices;
// //   OfficesList({required this.offices});
// //
// //   factory OfficesList.fromJson (Map<String, dynamic> json) {
// //
// //     var officesJson = json['offices'] as List;
// //
// //     List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();
// //
// //     return OfficesList(
// //       offices: officesList,
// //     );
// //   }
// // }
//
// // class Office {
// //   final String name;
// //   final String address;
// //   final String image;
// //
// //   Office({required this.name, required this.address, required this.image});
// //
// //   factory Office.fromJson(Map<String, dynamic> json) {
// //     return Office(
// //         name: json['name'] as String,
// //         address: json['address'] as String,
// //         image: json['image'] as String
// //     );
// //   }
// // }
//
// // Future<OfficesList> getOfficesList() async {
// //  const url = 'https://about.google/static/data/locations.json';
// //
// //   final response = await http.get(Uri.parse(url));
// //
// //   if(response.statusCode == 200) {
// //     return OfficesList.fromJson(json.decode(response.body));
// //   } else {
// //     throw Exception('Error: ${response.reasonPhrase}');
// //   }
// // }
//
// Future<UsersList> readJson() async {
//   var url = "http://localhost/test/users_list.php";
//   // var url = 'https://json.flutter.su/echo';
//   // var headers;
//   // var config = {
//   //   headers: {
//   //     "Access-Control-Allow-Origin": "*",
//   //     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
//   //   }
//   // };
//   final response = await http.get(Uri.parse(url), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
//     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
//   // print('response users');
//   //
//   // print(response.body);
//   // print(response.statusCode);
//   //final String response = await rootBundle.loadString('assets/data.json');
//   final data = await json.decode(response.body);
//
//   return UsersList.fromJson(json.decode(response.body));
//
// }
//
// // Future<ProductsList> readJson() async {
// //   final String response = await rootBundle.loadString('assets/products.json');
// //   final data = await json.decode(response);
// //   return ProductsList.fromJson(json.decode(response));
// //
// // }
