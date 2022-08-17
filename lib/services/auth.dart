import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cadillac/models/users.dart' as user;

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  get user => null;

  get authStateChanges => null;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = result.user;
      return user;
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return null;
    }

    // try{
    //   AuthResult result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
    //   FirebaseUser user = result.user;
    //   return User.fromFirebase(user);
    // }catch(e){
    //   print(e);
    //   return null;
    // }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try{
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }

  StreamSubscription<User?> getIdTokenChanges() {
    return FirebaseAuth.instance
        .idTokenChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print(user.uid);
      }
    });
  }


  StreamSubscription<User?> get currentUser{
    return FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
    // return _fAuth.AuthStateChanged
    //     .map((User? user) => user != null ? User.fromFirebase(user) : null);
  }

}