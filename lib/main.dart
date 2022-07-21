
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

//import 'dart:js';

import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/accountAdmin.dart';
import 'package:cadillac/pages/addBanners.dart';
import 'package:cadillac/pages/addNews.dart';
import 'package:cadillac/pages/addPartners.dart';
import 'package:cadillac/pages/cardProduct.dart';
import 'package:cadillac/pages/cardProductAdmin.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/editAccountAdmin.dart';
import 'package:cadillac/pages/editAds.dart';
import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/homeAdmin.dart';

import 'package:cadillac/pages/data.dart';
import 'package:cadillac/pages/login.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/membersAdmin.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/newsAdmin.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:cadillac/pages/registrationAdmin.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/success-payment.dart';
import 'package:cadillac/pages/test.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:form_builder_asset_picker/form_builder_asset_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
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


// class Data extends ChangeNotifier {
//   late final Map data = {
//     // 'userId': '77899126-ff7a-11ec-a426-002590eb3418',
//     //'userId': '7b791032-010c-11ed-a426-002590eb3418',
//     //userId': Uuid().v1(),
//     'userId': '',
//
//     'platform': checkPlatform(),
//     'isAuth': false,
//     //'images' : List<PlatformFile>
//   };
//
//   void updateAccount(value) {
//     print('update account');
//     data["userId"] = value;
//     //data["isAuth"] = true;
//     notifyListeners();
//   }
//
// }

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
  MyApp({Key? key,}) : super(key: key);
  static get platform => checkPlatform();
  late String cookies;

  //get userId => null;
  //final String data = '8f87d509-fb7e-11ec-a426-002590eb3418'; a@a - mobile
  //final String data = '871936c4-f009-11ec-a426-002590eb3418'; z@z - web

  @override
  Widget build(BuildContext context) {
    bool isAuth = false;
    //cookies = Provider.of<Data>(context).data['cookies'].toString();
    //print('cookies main');
    // if(_checkIsAuth(context)) {
    //   isAuth = true;
    // } else {
    //   isAuth = false;
    // }



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
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider.value(
    //         value: Data(),
    //       ),
    //     ],
    //     child: MaterialApp(
    return ChangeNotifierProvider<Data> (
      create: (context) => Data(),
        //builder: (context) => return Data(),
        //lazy: false,
        // builder: (context, child) {
        //   return Text(context.watch<Data>().toString());
        // },
      child: MaterialApp(
        theme: ThemeData (
          // primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        //initialRoute: '/account',
        initialRoute: '/home',


        routes: {
          '/home': (context) => Provider.of<Data>(context).data['cookies'].toString() != ''? Account() : RegistrationPage(),
          //'/home': (context) => Account(),
          //'/home': (context) => MembersAdmin(),
          //'/home': (context) => RegistrationAdmin(userId: '1aa71d78-f91c-11ec-a426-002590eb3418'),
          //'/home': (context) => Shop(),
          '/homeAdmin': (context) => const HomeAdmin(),
          '/registrationAdmin': (context) => RegistrationAdmin(),
          //'/home': (context) => Contacts(),
          //'/home': (context) =>  isAuth ? Account() : RegistrationPage(),
          //'/home': (context) => isAuth ? Account() : RegistrationPage(),
          //'/home': (context) => Test(),
          //'/home': (context) => AccountAdmin(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          //'/home': (context) => AddBanners(),
          //'/home': (context) => Account(userId:userId),
          //'/home': (context) => Members(),
          //'/home': (context) => Account(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          '/account': (context) => Account(),
          '/members': (context) => const Members(),
          '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          '/edit': (context) => Edit(),
          '/editAds': (context) => const EditAds(),
          '/editAdmin': (context) => EditAdmin(),
          '/test': (context) => const Test(),
          // '/card': (context) => Card(productId: 1),
          // '/success_payment': (context) => SuccessPayment(currentUser: currentUser),
          // '/success_payment': (context) => SuccessPayment(
          //   currentUser: currentUser),
        },

        home: MyHomePage(title: 'Cadillac'),
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

  //late Future<UsersList> usersList;

  @override
  void initState() {
    print('init state main');
    super.initState();
    //_checkIsAuth(context);
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


    );
  }



}
















