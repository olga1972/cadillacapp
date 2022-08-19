import 'package:cadillac/pages/registrationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cadillac/models/users.dart';
import 'package:cadillac/pages/auth.dart';
import 'package:cadillac/pages/account.dart';
import 'package:provider/provider.dart';

import '../variables.dart';
import 'accountAdmin.dart';
import 'contacts.dart';

//import '../services/auth.dart';


class Entrance extends StatelessWidget {
  Entrance({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print(currentUser.uid);
    }
    // можно прислать письмо на почту для верификации
    // if (user!= null && !user.emailVerified) {
    //   await user.sendEmailVerification();
    // }


    final bool isLoggedIn = currentUser != null;
    bool isAdmin = false;

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? currentUser) {
      if (currentUser == null) {
        print('User is currently signed out!');
        print(isLoggedIn);

      } else {
        print('User is signed in!');
        print(currentUser.email);
        print(isLoggedIn);

        if(currentUser.email == emailAdmin) {
          isAdmin = true;
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context) =>
                  AccountAdmin()
          ));
        } else {
          isAdmin = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context) =>
                  Account()
          ));
        }
      }
    });


    // return isLoggedIn ?
    //   isAdmin ? AccountAdmin() : Account()
    //     : AuthorizationPage();
    // return isLoggedIn ? Account() : AuthorizationPage();
    return AuthorizationPage();
  }
}