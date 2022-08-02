import 'package:flutter/material.dart' ;

import '../main.dart';

class Data with ChangeNotifier {
  bool isAuth = false;
  int counter = 0;
  String cookies = '';
  bool isAdmin = false;
  bool isShowConfirmRegister = false;

  late final Map data = {
    'userId': '',
    'counter': 0,
    'platform': checkPlatform(),
    'isAuth': false,
    'cookies': '',
    'isAdmin': false,
    'isShowConfirmRegister': false
  };

  void setCookie(value) {
    debugPrint('set cookie');
    data["cookie"] = value;
    notifyListeners();
  }

  void checkIsAdmin(value) {
    data["isAdmin"] = value;
    notifyListeners();
  }

  void checkIsShowConfirmRegister(value) {
    data["isShowConfirmRegister"] = value;
    notifyListeners();
  }

  void updateAccount(value) {
    debugPrint('update account');
    data["counter"] = value;
    notifyListeners();
  }

  void updateUserId(value) {
    debugPrint('update userId');
    data["userId"] = value;
    notifyListeners();
  }
}
