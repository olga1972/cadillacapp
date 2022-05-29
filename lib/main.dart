
// import 'package:cadillac/services/db.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:cadillac/task_model.dart';
// import 'package:build_runner/build_runner.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/login.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/success-payment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../env.dart';
import '../models/user.dart';
import '../utils/app_url.dart';
// import './details.dart';
// import './create.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:cadillac/models/users.dart';

// import 'client/hive_names.dart';

import 'package:cadillac/pages/registrationPage.dart';
import 'package:cadillac/pages/login.dart';
import 'package:cadillac/NavDrawer.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final currentUser;

  MyApp({Key? key,}) : super(key: key);
  final currentUser = User(email: 'olga.sadyreva@mail.ru', phone: '9221238853', username: 'Olga');
  //get currentUser => null;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData (
        // primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF181c33)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,
      //initialRoute: '/account',
      initialRoute: '/home',


      routes: {
        //'/': (context) => RegistrationPage(),
        //'/home': (context) => SuccessPayment(),
        '/home': (context) => RegistrationPage(),
        // '/home': (context) => Account(),
        // '/home': (context) => Home(),
        '/account': (context) => Account(currentUser: currentUser),
        '/members': (context) => Members(),
        '/news': (context) => News(),
        '/shop': (context) => Shop(),
        '/partners': (context) => Partners(),
        '/contacts': (context) => Contacts(),
        // '/success_payment': (context) => SuccessPayment(currentUser: currentUser),
        // '/success_payment': (context) => SuccessPayment(
        //   currentUser: currentUser),
      },

      //home: MyHomePage(title: 'Cadillac'),
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case '/':
        //       final page = Contacts();
        //       return MaterialPageRoute(builder: (context) => page);
        //
        //     case '/home':
        //       final page = Home();
        //       return MaterialPageRoute(builder: (context) => page);
        //
        //     // case 'home':
        //     //   return MaterialPageRoute(builder: (context) => Home());
        //
        //     case 'account':
        //       return MaterialPageRoute(builder: (context) => Account());
        //
        //     case 'news':
        //     //final user = settings.arguments as User;
        //       final page = News();
        //       return MaterialPageRoute(
        //
        //           settings: settings,
        //           // builder: (context) => News(user: user));
        //           builder: (context) => page);
        //
        //
        //     case 'members':
        //     //final user = settings.arguments as User;
        //       return MaterialPageRoute(
        //         // builder: (context) => News(user: user));
        //           builder: (context) => Members()
        //       );
        //
        //     default:
        //       return MaterialPageRoute(builder: (context) => Home());
        //   }
        // }


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // late Future<UsersList> usersList;

  @override
  void initState() {
    print('initstate');
    super.initState();

    // usersList = getUsersList();
    // print("usersList: ${getUsersList()}");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Home(),
        // body: Text('2Став владельцем Cadillac, \nвы не просто приобретаете \nавтомобиль класса-люкс, \nвы вступаете в элитное сообщество, единомышленников, объединённых общими ценностями и интересами.'.toUpperCase(),
        //   style:const TextStyle (
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.normal,
        //     fontFamily: 'CadillacSans',
        //     color: Color(0xFF8F97BF),
        //     height: 1.7, //line-height : font-size
        //   ),
        //   textAlign: TextAlign.center,
        //   softWrap: true,
        // ),
      drawer: const NavDrawer(),
        //body: FutureBuilder<UsersList>(
        //   future: usersList,
        //   builder: (context, snapshot) {
        //     print(snapshot.data);
        //     if (snapshot.hasData) {
              // return ListView.builder(
              //     itemCount: snapshot.data?.users.length,
              //     itemBuilder: (context, index) {
              //       return Card(
              //         child: ListTile(
              //           // title: Text('${snapshot.data?.users[index].email}'),
              //           title: Text('users'),
              //         ),
              //       );
              //     }
              // );
          //   } else if (snapshot.hasError) {
          //     return const Text('Error');
          //   }
          //   return const Center(child: CircularProgressIndicator());
          // },

        //)

    );
  }

  // Future<UsersList> getUsersList() async {
  //   var url = "http://localhost/test/login.php";
  //   final response = await http.get(Uri.parse(url));
  //   // final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //   // List<UsersList> user = items.map<User>((json) {
  //   //   return User.fromJson(json);
  //   // }).toList();
  //
  //   // return user;
  //   if (response.statusCode == 200) {
  //     return UsersList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }
}













