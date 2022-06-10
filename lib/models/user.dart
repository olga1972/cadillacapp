import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class UsersList {
  List<User>? users;
  UsersList({required this.users});

  factory UsersList.fromJson(Map<String, dynamic> json) {
    print(json);
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

  late final String login;
  late final String password;
  late final String carname;

  User({
    required this.userId,
    required this.phone,
    required this.email,
    required this.username,
    required this.birthday,

    required this.login,
    required this.password,
    required this.carname
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      birthday: json['birthday'] as String,

      login: json['login'] as String,
      password: json['password'] as String,
      carname: json['carname'] as String,
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

    data['login'] = this.login;
    data['password'] = this.password;
    data['carname'] = this.carname;
    return data;
  }
}
