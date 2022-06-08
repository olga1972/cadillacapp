import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UsersList {
  List<User> users;
  UsersList({required this.users});

  factory UsersList.fromJson (Map<String, dynamic> json) {
    print('from json userstList');
    print(json);
    print(json['users']);
    var usersJson = json['users'] as List;

    print('usersJson');
    print(usersJson);
    List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();

    print('usersList');
    print(usersList);
    print(usersList.runtimeType);

    return UsersList(
      users: usersList,
    );
  }
}

class User {
  late final int id;
  late final String userId;
  late final String username;
  late final String email;
  late final String phone;
  late final String birthday;
  late final String login;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.login,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      login: json['login'] as String
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

Future<UsersList> readJson() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final data = await json.decode(response);
  return UsersList.fromJson(json.decode(response));

}






// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
//
//
// class UsersList {
//   List<User> users;
//   UsersList({required this.users});
//
//   factory UsersList.fromJson (Map<String, dynamic> json) {
//     print('from json userList');
//     print(json);
//     print(json['users']);
//     // if (json['users'] != null) {
//     var usersJson = json['users'] as List;
//
//     print('usersJson');
//       print(usersJson);
//
//       List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();
//     print('usersList');
//       print(usersList);
//       print(usersList.runtimeType);
//       return UsersList(
//         users: usersList,
//       );
//
//   }
// }
//
//
// class User {
//   final int id;
//   final String userId;
//   final String phone;
//   final String email;
//   final String username;
//   final String birthday;
//   // late final int id;
//   // late final String userId;
//   // late final String phone;
//   // late final String email;
//   // late final String username;
//   // late final String birthday;
//
//   // late final String login;
//   // late final String password;
//   // late final String car;
//
//   User({
//     required this.id,
//     required this.userId,
//     required this.phone,
//     required this.email,
//     required this.username,
//     required this.birthday,
//
//     // required this.login,
//     // required this.password,
//     // required this.car
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       userId: json['userId'] as String,
//       phone: json['phone'] as String,
//       email: json['email'] as String,
//       username: json['username'] as String,
//       birthday: json['birthday'] as String,
//
//       // login: json['login'] as String,
//       // password: json['password'] as String,
//       // car: json['car'] as String,
//     );
//
//   }
//
//   Future<UsersList> getUsersList() async {
//     // const url = 'https://about.google/static/data/locations.json';
//     const url = 'http://localhost/test/users_list.php';
//     // const url = 'http://localhost/test/users.json';
//     final response = await http.get(Uri.parse(url));
//
//     if(response.statusCode == 200) {
//       return UsersList.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Error: ${response.reasonPhrase}');
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['username'] = this.username;
//     data['birthday'] = this.birthday;
//
//     // data['login'] = this.login;
//     // data['password'] = this.password;
//     // data['car'] = this.car;
//     return data;
//   }
// }
//
// Future<UsersList> readJson() async {
//   final String response = await rootBundle.loadString('assets/users.json');
//   final data = await json.decode(response);
//   return UsersList.fromJson(json.decode(response));
//
// }