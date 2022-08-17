import 'package:firebase_auth/firebase_auth.dart';

class User {
  late String id;

  User.fromFirebase(user){
    id = user.uid;
  }
}