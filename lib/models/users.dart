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
  late final String id;
  late final String userId;
  late final String username;
  late final String email;
  late final String phone;
  late final String birthday;
  late final String login;
  late final String carname;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.login,
    required this.carname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      login: json['login'] as String,
      carname: json['carname'] as String
    );
  }


  Future<UsersList> getUsersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    const url = 'http://localhost/test/users_list.php';
    final response = await http.get(Uri.parse(url));
    print('response body user getUsersList');
    print('response body');
    if(response.statusCode == 200) {
      return UsersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['birthday'] = this.birthday;

    data['login'] = this.login;
    // data['password'] = this.password;
    data['carname'] = this.carname;
    return data;
  }
}

Future<UsersList> readJson() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final data = await json.decode(response);
  print('userlist readJson');
  return UsersList.fromJson(json.decode(response));

}
