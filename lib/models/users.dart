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
  late final String? path;
  late final String car1;
  late final String car2;
  late final String car3;

  User({
    required this.id,
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
    //this.photo,
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
      carname: json['carname'] as String,
      path: json['path'] as String,
      car1: json['car1'] as String,
      car2: json['car2'] as String,
      car3: json['car3'] as String
    );
  }


  Future<UsersList> getUsersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    // const url = 'http://localhost/test/users_list.php';
    const url = 'https://cadillacapp.ru/test/users_list.php';
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['birthday'] = birthday;

    data['login'] = login;
    // data['password'] = this.password;
    data['carname'] = carname;
    data['path'] = path;
    data['car1'] = car1;
    data['car2'] = car2;
    data['car3'] = car3;
    return data;
  }
}

Future<UsersList> readJson() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final data = await json.decode(response);
  print('userlist readJson');
  return UsersList.fromJson(json.decode(response));

}

