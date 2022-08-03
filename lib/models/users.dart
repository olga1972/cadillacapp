import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UsersList {
  List<User> users;
  UsersList({required this.users});

  factory UsersList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json usersList');
    var usersJson = json['users'] as List;
    debugPrint(usersJson.toString());
    List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();
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
  late final String? path;
  late final String car1;
  late final String car2;
  late final String car3;
  late final String password;
  late final dynamic dateRegister;
  late final dynamic dateExpired;

  User(
      {required this.id,
      required this.userId,
      required this.username,
      required this.email,
      required this.phone,
      required this.birthday,
      required this.login,
      required this.carname,
      required this.path,
      required this.car1,
      required this.car2,
      required this.car3,
      required this.password,
      required this.dateRegister,
      required this.dateExpired});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      login: json['login'] as String,
      carname: json['carname'] as String,
      path: json['path'] as String,
      car1: json['car1'] as String,
      car2: json['car2'] as String,
      car3: json['car3'] as String,
      password: json['password'] as String,
      dateRegister: json['dateRegister'] as dynamic,
      dateExpired: json['dateExpired'] as dynamic,
    );
  }

  Future<UsersList> getUsersList() async {
    const url = 'https://cadillacapp.ru/test/users_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body user getUsersList');
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return UsersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['birthday'] = birthday;
    data['login'] = login;
    data['carname'] = carname;
    data['path'] = path;
    data['car1'] = car1;
    data['car2'] = car2;
    data['car3'] = car3;
    data['password'] = password;
    data['dateRegister'] = dateRegister;
    data['dateExpired'] = dateExpired;
    return data;
  }
}

Future<UsersList> readJson() async {
  final String response = await rootBundle.loadString('assets/users.json');
  return UsersList.fromJson(json.decode(response));
}
