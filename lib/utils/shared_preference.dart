import 'package:cadillac/models/user2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("type", user.type);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);

    print("object prefere");
    print(user.renewalToken);

    return true;
    // return prefs.commit();

  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    dynamic userId = prefs.getString("userId");
    dynamic name = prefs.getString("name");
    dynamic email = prefs.getString("email");
    dynamic phone = prefs.getString("phone");
    dynamic type = prefs.getString("type");
    dynamic token = prefs.getString("token");
    dynamic renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        type: type,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("token");
    return token;
  }
}