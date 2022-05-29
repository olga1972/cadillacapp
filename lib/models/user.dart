
// part 'user.g.dart';
import 'dart:convert';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class User {
  final String? userId;
  final String? email;
  final String? phone;
  final String? login;
  final String? password;
  final String? photo;
  final String? username;
  final String? birthday;
  final String? phone2;
  final String? car;
  // final List<String>? cars;
  final String? address;

  User(
      {this.userId,
        this.email,
        this.phone,
        this.login,
        this.password,
        this.photo,
        this.username,
        this.birthday,
        this.phone2,
        this.car,
        // this.cars,
        this.address});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        userId: jsonData['userId'],
        email: jsonData['email'],
        phone: jsonData['phone'],
        login: jsonData['login'],
        password: jsonData['password'],
        photo: jsonData['photo'],
        username: jsonData['username'],
        birthday: jsonData['birthday'],
        phone2: jsonData['phone2'],
        car: jsonData['car'],
        // cars: jsonData['cars'],
        address: jsonData['address'],
    );

  }

  @override
  String toString() => 'UserId: $userId, Phone: $phone, Email: $email';

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['userId'] = this.userId;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['login'] = this.login;
  //   data['password'] = this.password;
  //   if (this.photo != null) {
  //     data['photo'] = this.photo!.toJson();
  //   }
  //   data['name'] = this.name;
  //   data['birthday'] = this.birthday;
  //   data['phone2'] = this.phone2;
  //   data['car'] = this.car;
  //   data['address'] = this.address;
  //   return data;
  // }
}

// class XFile {
//     XFileImage? photo1;
//
// }
//
class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

// class Cars {
//   String? photo1;
//   String? photo2;
//   String? photo3;
//
//
//   Cars({this.photo1, this.photo2, this.photo3});
//
//   Cars.fromJson(Map<String, dynamic> json) {
//     photo1 = json['photo1'];
//     photo2 = json['photo2'];
//     photo3 = json['photo3'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['photo1'] = this.photo1;
//     data['photo2'] = this.photo2;
//     data['photo3'] = this.photo2;
//     return data;
//   }
// }
//
// class User {
//
//   late dynamic userId;
//   late dynamic name;
//   late dynamic login;
//   late dynamic birthday;
//   late dynamic email;
//   late dynamic password;
//   late dynamic phone;
//   late dynamic type;
//   late dynamic car;
//   late final dynamic token;
//   late final dynamic renewalToken;
//   late final dynamic photo;
//   late final dynamic cars;
//
//   User({
//     this.userId = '5555',
//     this.name = 'ivan',
//     this.login = 'ivan@mail.ru"',
//     this.birthday = '19.04.1972',
//     this.email = 'ivan@mail.ru"',
//     this.phone = '123456789',
//     this.password = '123',
//     this.type = 'text',
//     this.car = 'cadillac',
//     this.token = '123',
//     this.renewalToken = '123456',
//     this.photo = 'assets/images/avatar.png',
//     this.cars = const [ 'assets/images/cadillac-eldorado.png',
//       "assets/images/cadillac-escalada.png",
//       "assets/images/cadillac-orange.png",
//     ],
//   });
//
//
//   factory User.fromJson(Map<String, dynamic> responseData) {
//     return User(
//         userId: responseData['userId'],
//         name: responseData['name'],
//         login: responseData['login'],
//         birthday: responseData['birthday'],
//         email: responseData['email'],
//         phone: responseData['phone'],
//         password: responseData['password'],
//         type: responseData['type'],
//         token: responseData['access_token'],
//         renewalToken: responseData['renewal_token'],
//         photo: responseData['photo'],
//         cars: responseData['cars'],
//     );
//   }
//
//   @override
//   String toString() => 'Phone: $phone, Email: $email';
// }