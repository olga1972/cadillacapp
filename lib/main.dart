import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/cardProduct.dart';
import 'package:cadillac/pages/cardProductAdmin.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/editAccountAdmin.dart';
import 'package:cadillac/pages/editAds.dart';
import 'package:cadillac/pages/entrance.dart';
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
//import 'package:cadillac/services/auth.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:cadillac/pages/registrationPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,}) : super(key: key);
  static get platform => checkPlatform();

  //get user => _auth.currentUser;
  final User? user = _auth.currentUser;

  //final String cookies ='';
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<Data> (
      //final auth = Provider.of(context).auth;
      // return StreamProvider<User?>.value(
      //     value: user,
      //     initialData: null,
      //   child: Entrance()
      //
      //       // final bool loggedIn = auth;
      //       // if (loggedIn == true) {
      //       //   return Contacts();
      //       // } else {
      //       //   return Entrance();
      //       // }
      //     //}
      //     //return CircularProgressIndicator();
      //   //},
      // );
   // }

//       return StreamBuilder<User?>(
//
//         stream: FirebaseAuth.instance.authStateChanges(),
//           Builder(builder: (BuildContext context) {
// //5
//             return MaterialButton(
//               child: const Text('Sign out'),
//               textColor: Colors.white,
//               onPressed: () async {
//                 final User? user = await _auth.currentUser;
//                 if (user == null) {
//                   debugPrint('No one has signed in.');
//                   return;
//                 }
//                 await _auth.signOut();
//                 final String uid = user.uid;
//                 debugPrint(uid + ' has successfully signed out.');
//
//               },
//             );
//           })
//       );

          //value: user,
      // create: (context) => Data(),
      //initialData: null,
      return MaterialApp(
        theme: ThemeData (
          // primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',


        routes: {
          '/home': (context) => Entrance(),
          //'/home': (context) => Provider.of<Data>(context, listen: false).data['userId'].toString() != ''? const Account() : const RegistrationPage(),
          //'/home': (context) => Account(),
          //'/home': (context) => MembersAdmin(),
          //'/home': (context) => RegistrationPage(),
          //'/home': (context) => CardProductAdmin(index: 0),
          '/homeAdmin': (context) => const HomeAdmin(),
          '/registrationAdmin': (context) => const RegistrationAdmin(),
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
      //)
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
                                RegistrationPage()));
                  }
            )
              ]
          )
        )


    );
  }



}
















