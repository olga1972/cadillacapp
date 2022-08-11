import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/cardProduct.dart';
import 'package:cadillac/pages/cardProductAdmin.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/editAccountAdmin.dart';
import 'package:cadillac/pages/editAds.dart';
import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/homeAdmin.dart';

import 'package:cadillac/pages/data.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/membersAdmin.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:cadillac/pages/registrationAdmin.dart';
import 'package:cadillac/pages/renewAccount.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/shopAdmin.dart';
import 'package:cadillac/pages/test.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:cadillac/pages/registrationPage.dart';


checkPlatform() {
  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {

    return 'android';
  }
  else if (defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows) {
    // Some desktop specific code there
    return 'windows';
  }
  else {
    // Some web specific code there
  }
}
Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,}) : super(key: key);
  static get platform => checkPlatform();
  //final String cookies ='';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data> (
      create: (context) => Data(),
      child: MaterialApp(
        theme: ThemeData (
          // primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',


        routes: {
          //'/home': (context) => Provider.of<Data>(context).data['cookies'].toString() != ''? const Account() : const RegistrationPage(),
          //'/home': (context) => Account(),
          //'/home': (context) => MembersAdmin(),
          '/home': (context) => RegistrationPage(),
          //'/home': (context) => CardProductAdmin(index: 0),
          '/homeAdmin': (context) => const HomeAdmin(),
          '/registrationAdmin': (context) => RegistrationAdmin(),
          //'/home': (context) => Contacts(),
          //'/home': (context) =>  isAuth ? Account() : RegistrationPage(),
          //'/home': (context) => isAuth ? Account() : RegistrationPage(),
          //'/home': (context) => Test(),
          //'/home': (context) => AccountAdmin(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          //'/home': (context) => PartnersAdmin(),
          //'/home': (context) => Account(userId:userId),
          //'/home': (context) => Members(),
          //'/home': (context) => Account(userId:'f1c7fde2-ef1b-11ec-a426-002590eb3418'),
          '/account': (context) => const Account(),
          '/members': (context) => const Members(),
          '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          '/edit': (context) => Edit(),
          '/editAds': (context) => const EditAds(),
          '/editAdmin': (context) => EditAdmin(),
          '/test': (context) => const Test(),
          '/renewAccount': (context) => const RenewAccount(),
          // '/card': (context) => Card(productId: 1),
          // '/success_payment': (context) => SuccessPayment(currentUser: currentUser),
          // '/success_payment': (context) => SuccessPayment(
          //   currentUser: currentUser),
        },

        home: const MyHomePage(title: 'Cadillac'),
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

  @override
  void initState() {
    debugPrint('init state main');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 284,
                  margin: const EdgeInsets.only(
                      bottom: 58),
                  child: const TitlePage(
                      title: 'главная'),
                ),
                Text('Став владельцем Cadillac, \nвы не просто приобретаете \nавтомобиль класса-люкс, \nвы вступаете в элитное сообщество, единомышленников, объединённых общими ценностями и интересами.'.toUpperCase(),
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
                const SizedBox(
                    height: 40
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(17),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  // textColor: const Color(0xFF12141F),
                  child: Text(
                    "На страницу регистрации".toUpperCase(),
                    style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF12141F)),
                  ),

                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius:
                    BorderRadius.all(
                    Radius.circular(10),
                    ),
                    ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder:
                                (context) =>
                                const RegistrationPage()));
                  }
            )
              ]
          )
        )


    );
  }



}
















