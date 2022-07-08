
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
import 'package:cadillac/pages/accountAdmin.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/editAccountAdmin.dart';
import 'package:cadillac/pages/editAds.dart';
import 'package:cadillac/pages/homeAdmin.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/registrationAdmin.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/success-payment.dart';
import 'package:cadillac/pages/test.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:form_builder_asset_picker/form_builder_asset_picker.dart';
import 'package:provider/provider.dart';
//import 'package:http/browser_client.dart';
import 'dart:async';
//import 'dart:html' as html;




import '../models/users.dart';
//import '../models/user.dart';

// import './details.dart';
// import './create.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:cadillac/models/users.dart';

// import 'client/hive_names.dart';

import 'package:cadillac/pages/registrationPage.dart';



checkPlatform() {
  String platform;

  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {

    return platform = 'android';
  }
  else if (defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows) {
    // Some desktop specific code there
    return platform = 'windows';
  }
  else {
    // Some web specific code there
  }
}

class Data extends ChangeNotifier {
  late final Map data = {
    'userId': '871936c4-f009-11ec-a426-002590eb3418',
    'platform': checkPlatform(),
    'isAuth': bool,
    'images' : List<PlatformFile>
  };

  void updateAccount(value) {
    data["images"] = value;
    notifyListeners();
  }
}

Future<void> main() async {
  runApp(MyApp());



//   var dio = Dio();
//   // List<Cookie> cookies = [
//   //   new Cookie("uuid", "9265988f-e70d-11ec-af6a-00ff21c5bb0a"),
//   //   // ....
//   // ];
//
//
//   var cookieJar = PersistCookieJar();
//   dio.interceptors.add(CookieManager(cookieJar));
//   //Save cookies
//   // cookieJar.saveFromResponse(Uri.parse("http://localhost"), cookies);
//
// //Get cookies
//   cookieJar.loadForRequest(Uri.parse(baseUrl));
//   print(cookieJar.loadForRequest(Uri.parse(baseUrl)));
//
//   //print(cookies);
//   await dio.get(baseUrl);


  // print(cookieJar);
  //
  // dio.interceptors.add(CookieManager(cookieJar));
  // dynamic result = await dio.get("http://localhost");
  // // Print cookies
  // print(cookieJar.loadForRequest(Uri.parse("http://localhost")));
  // // second request with the cookie
  // await dio.get("http://localhost");
}

class MyApp extends StatelessWidget {
  //final currentUser;

  MyApp({Key? key,}) : super(key: key);
  // final currentUser = User(
  //     id: '1',
  //     userId: '1111',
  //     email: 'olga.sadyreva@mail.ru',
  //     phone: '9221238853',
  //     username: 'Olga',
  //     birthday: '19.04.1972',
  //     login: 'olga.sadyreva@mail.ru',
  //     photo: '',
  //     // password: '11111',
  //     carname: 'wwww',
  //     // login: 'wwwww'
  //     );



  static get platform => checkPlatform();

  get userId => null;
  //get currentUser => null;
  late String cookies;
  //final String data = '8f87d509-fb7e-11ec-a426-002590eb3418'; a@a - mobile
  //final String data = '871936c4-f009-11ec-a426-002590eb3418'; z@z - web






  @override
  Widget build(BuildContext context) {

    //при сборке под web ошибка
    // if (IO.Platform.isAndroid) {
    //   print('android');
    // } else if (IO.Platform.isIOS) {
    //   print('ios');
    // } else {
    //   print('windows');

      // cookies = html.window.document.cookie!;
      // print(cookies);
    //}

    return ChangeNotifierProvider<Data> (
      create: (context) => Data(),
      child: MaterialApp(
        theme: ThemeData (
          // primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        //initialRoute: '/account',
        initialRoute: '/home',


        routes: {
          '/home': (context) => const RegistrationPage(),
          //'/home': (context) => RegistrationAdmin(userId: '1aa71d78-f91c-11ec-a426-002590eb3418'),
          //'/home': (context) => Account(),
          '/homeAdmin': (context) => const HomeAdmin(),
          '/registrationAdmin': (context) => RegistrationAdmin(),
          //'/home': (context) => SuccessPayment(),
          //'/home': (context) => cookies != null && cookies != '' ? AccountAdmin(userId: '1aa71d78-f91c-11ec-a426-002590eb3418') : RegistrationPage(),
          //'/home': (context) => Test(),
          //'/home': (context) => AccountAdmin(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          //'/home': (context) => Contacts(),
          //'/home': (context) => Account(userId:userId),
          //'/home': (context) => Home(),
          //'/home': (context) => Account(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          '/account': (context) => Account(),
          '/members': (context) => const Members(),
          '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          '/edit': (context) => const Edit(),
          '/editAds': (context) => const EditAds(),
          '/editAdmin': (context) => const EditAdmin(),
          '/test': (context) => const Test(),
          // '/card': (context) => Card(productId: 1),
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

      )
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

  late Future<UsersList> usersList;

  @override
  void initState() {
    print('init state main');
    super.initState();

    // var usersList = getUsersList();
    // print("usersList: ${getUsersList()}");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // body:Home(),
        body: Text('2Став владельцем Cadillac, \nвы не просто приобретаете \nавтомобиль класса-люкс, \nвы вступаете в элитное сообщество, единомышленников, объединённых общими ценностями и интересами.'.toUpperCase(),
          style:const TextStyle (
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'CadillacSans',
            color: Color(0xFF8F97BF),
            height: 1.7, //line-height : font-size
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),

        // body: FutureBuilder<UsersList>(
        //   future: usersList,
        //   builder: (context, snapshot) {
        //     print(snapshot.data);
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //           itemCount: snapshot.data?.users?.length,
        //           itemBuilder: (context, index) {
        //             return Card(
        //               child: ListTile(
        //                 // title: Text('${snapshot.data?.users[index].email}'),
        //                 title: Text('users'),
        //               ),
        //             );
        //           }
        //       );
        //     } else if (snapshot.hasError) {
        //       return const Text('Error');
        //     }
        //     return const Center(child: CircularProgressIndicator());
        //   },
        //
        // ),

        //drawer: NavDrawer(),


    );
  }
  // Future<String> getTestString() async {
  //   if (_client is BrowserClient)
  //     (_client as BrowserClient).withCredentials = true;
  //   await _client.get('https://localhost/api/login');
  //   await _client.get('https://localhost/api/login');
  //   return 'blah';
  // }
  // Future<UsersList> getUsersList() async {
  //   // const url = 'https://about.google/static/data/locations.json';
  //   // const url = 'http://localhost/test/users_list.php';
  //   const url = baseUrl + '/users_list.php';
  //   final response = await http.get(Uri.parse(url));
  //
  //   if(response.statusCode == 200) {
  //     return UsersList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // Future<UsersList> getUsersList() async {
  //   var url = "http://localhost/test/users_list.php";
  //   final response = await http.get(Uri.parse(url));
  //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //   List<UsersList> user = items.map<User>((json) {
  //     return User.fromJson(json);
  //   }).toList();
  //
  //   // return user;
  //   if (response.statusCode == 200) {
  //     return UsersList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }
}















