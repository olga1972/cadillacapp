import 'package:flutter/material.dart' ;
import 'package:uuid/uuid.dart';

import '../main.dart';

class Data with ChangeNotifier {
  bool isAuth = false;
  int counter = 0;
  String cookies = '';
  bool isAdmin = false;
  bool isShowConfirmRegister = false;
//   var _count = 0
// int get getCounter {
//  return _count;
// }
//  void incrementCounter() {
//  _count += 1 ;
//  notifyListeners();
//  }

  late final Map data = {
    // 'userId': '77899126-ff7a-11ec-a426-002590eb3418',
    //'userId': '7b791032-010c-11ed-a426-002590eb3418',
    //'userId': Uuid().v1(),
    'userId': '',
    'counter': 0,
    'platform': checkPlatform(),
    'isAuth': false,
    'cookies': '',
    'isAdmin': false,
    'isShowConfirmRegister': false
    //'images' : List<PlatformFile>
  };

  void setCookie(value) {
    print('set cookie');
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
    print('update account');
    data["counter"] = value;
    //data["isAuth"] = true;
    notifyListeners();
  }

  void updateUserId(value) {
    print('update userId');
    data["userId"] = value;
    //data["isAuth"] = true;
    notifyListeners();
  }

  // void checkIsAuth(value1, value2) {
  //   isAuth = value1;
  //   counter = value2;
  //   notifyListeners();
  // }



}
