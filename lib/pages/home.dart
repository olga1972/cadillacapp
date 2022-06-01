import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/src/material/input_border.dart';
import 'package:flutter/src/material/material_localizations.dart';
//import 'package:cadillac/NavBar.dart';

//import 'package:cadillac/CustomAppBar.dart';

import 'package:cadillac/pages/registrationPage.dart';
import 'package:cadillac/pages/success-payment.dart';
import 'package:cadillac/pages/payment.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
import 'package:cadillac/widgets/bannersList.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/users.dart';
// import '../models/user.dart';
import 'login.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<UsersList> usersList;

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    usersList = getUsersList();
    // usersList = readJson();
    // setState(() {
    //   _items = data["items"];
    // });
  }




  //usersList = readJson();
  @override

  Widget build(BuildContext context) {
    // var usersList = getUsersList();
    // print("usersList: ${usersList}");
    // return MaterialApp(
    //     theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
    //
    //     title: 'Cadillac',
    //     debugShowCheckedModeBanner: false,
    //     //initialRoute: '/home',  error не
    //    initialRoute: '/account',
    //     routes: {

          // '/home': (context) => Account(),

          // '/home': (context) => Home(),
          // '/account': (context) => Account(),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          // '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),
          // '/success_payment': (context) => SuccessPayment(),

        // },
return Scaffold(
  body: FutureBuilder<UsersList>(

    future: usersList,
    builder: (context, AsyncSnapshot snapshot)
    {
      print('snapshot.data home');
      //print(snapshot.data.users);
      // if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.users?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('${snapshot.data?.users[index].email}'),
                  // title: Text('users'),
                ),
              );
            }
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else {
        print('error');
        return Text('error');
      }
    }
  )
);


    }


        // home: Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: const Color(0xFF181c33),
        //     shadowColor: Colors.transparent,
        //     leading: Builder(
        //       builder: (BuildContext context) {
        //         return IconButton(
        //           icon: SvgPicture.network(
        //             'assets/images/burger.svg',
        //             semanticsLabel: 'Icon burger',
        //             height: 12.0),
        //           onPressed: () { Scaffold.of(context).openDrawer(); },
        //           tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //         );
        //       },
        //     ),
        //   ),
        //
        //   body: Center (
        //     child: Container (
        //       width: 284,
        //       child: Column (
        //           children: [
        //             const TitlePage(title: 'главная'),
        //
        //             Container (
        //               margin: const EdgeInsets.only(top: 100, bottom: 100),
        //               child: (
        //                   Text('Став владельцем Cadillac, \nвы не просто приобретаете \nавтомобиль класса-люкс, \nвы вступаете в элитное сообщество, единомышленников, объединённых общими ценностями и интересами.'.toUpperCase(),
        //                     style:const TextStyle (
        //                       fontSize: 14.0,
        //                       fontWeight: FontWeight.normal,
        //                       fontFamily: 'CadillacSans',
        //                       color: Color(0xFF8F97BF),
        //                       height: 1.7, //line-height : font-size
        //                     ),
        //                     textAlign: TextAlign.center,
        //                     softWrap: true,
        //                   )
        //               )
        //
        //             ),
        //
        //             Container (
        //               width: MediaQuery.of(context).size.width,
        //               height: 200,
        //               padding: EdgeInsets.zero,
        //               margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
        //               color: const Color(0xFF181C33),
        //               child: Banners(),
        //             ),
        //
        //             const TitlePage(title: 'мы в соцсетях'),
        //
        //             Socials(),
        //
        //           ]
        //
        //       ),
        //   )
        // ),

          //body: Home(),

          // drawer: NavDrawer(),



  //       ),
  //
  //
  //   );
  // }
}

Future<UsersList> getUsersList() async {
  // const url = 'https://about.google/static/data/locations.json';
  const url = 'http://localhost/test/users_list.php';
  final response = await http.post(Uri.parse(url));

  if(response.statusCode == 200) {
    return UsersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}