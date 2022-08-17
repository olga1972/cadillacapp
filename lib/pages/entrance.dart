import 'package:cadillac/pages/registrationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cadillac/models/users.dart';
import 'package:cadillac/pages/auth.dart';
import 'package:cadillac/pages/account.dart';
import 'package:provider/provider.dart';

import 'contacts.dart';

//import '../services/auth.dart';


class Entrance extends StatelessWidget {
  Entrance({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    //final auth = Provider.of(context).auth;

    //late bool isLoggedIn;

    User? user = FirebaseAuth.instance.currentUser;
    // final dynamic user = Provider.of<User>(context);
    final bool isLoggedIn = user != null;

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        print(isLoggedIn);

      } else {
        print('User is signed in!');
        print(isLoggedIn);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(
        //     builder: (context) =>
        //     const Contacts()
        // ));

      }
    });


    return isLoggedIn ? Account() : AuthorizationPage();
    //return isLoggedIn ? Account() : RegistrationPage();
  }
}