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
import 'package:cadillac/pages/test.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
import 'package:cadillac/widgets/bannersList.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/models/users.dart';
import 'package:cadillac/models/products.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'gift.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<UsersList> usersList;
  //late Future<ProductsList> productsList;

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    //usersList = getUsersList();
    //productsList = readJson();
    //usersList = readJsonUsers();
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
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        //initialRoute: '/account',

        routes: {
          '/home': (context) => Home(),
          // '/account': (context) => Account(currentUser: currentUser,),
          '/members': (context) => Members(),
          '/news': (context) => const News(),
          // '/shop': (context) => Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),
          '/gift': (context) => const Gift(),
          // '/test': (context) => Test()

        },
        // home: Scaffold(
        //     appBar: AppBar(
        //         backgroundColor: const Color(0xFF181c33),
        //         shadowColor: Colors.transparent,
        //         leading: Builder(
        //             builder: (BuildContext context) {
        //               return IconButton(
        //                 icon: SvgPicture.asset('assets/images/burger.svg'),
        //                 onPressed: () { Scaffold.of(context).openDrawer(); },
        //                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //               );
        //             },
        //         ),
        //     ),
        //   body: FutureBuilder<UsersList>(
        //     future: usersList,
        //     builder: (context, snapshot) {
        //       print('snapshot.data.users');
        //       var users = snapshot.data?.users;
        //       final List<User>? usersList = snapshot.data?.users;
        //           // .where((p) => p.id != 1).toList();
        //       print(usersList);
        //       // fruits.where((f) => f.startsWith('a')).toList(); //apples
        //       // products.where((p) => p.category = products[0]?.category).toList();
        //       // final selectedCategory = snapshot.data?.products.where((u) => u.category.contains('футболка')).toList();
        //       // print(snapshot.data?.products[0].category);
        //       // print(selectedCategory);
        //       if (snapshot.hasData) {
        //         return ListView.builder(
        //             itemCount: snapshot.data?.users.length,
        //             //   itemCount: selectedCategory?.length,
        //             itemBuilder: (context, index) {
        //               return Card(
        //                 child: ListTile(
        //                   title: Text('${snapshot.data?.users[index]?.username}'),
        //                   subtitle:
        //                   Text('${snapshot.data?.users[index]?.email}'),
        //
        //                   isThreeLine: true,
        //                 ),
        //               );
        //             });
        //
        //       } else if (snapshot.hasError) {
        //         print(snapshot.data);
        //         return const Text('Error');
        //       }
        //       return const Center(child: CircularProgressIndicator());
        //     },
        //   ),
//
//   body: FutureBuilder<UsersList>(
//
//     future: usersList,
//     builder: (context, AsyncSnapshot snapshot)
//     {
//       print('snapshot.data home');
//       print(snapshot.data);
//       // if (snapshot.connectionState == ConnectionState.done) {
//       if (snapshot.hasData) {
//         return ListView.builder(
//             // itemCount: snapshot.data.users?.length,
//             itemCount: 6,
//             itemBuilder: (context, index) {
//               return Card(
//                 child: ListTile(
//                   // title: Text('${snapshot.data?.users[index].email}'),
//                   title: Text('users'),
//                 ),
//               );
//             }
//         );
//       } else if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else {
//         print('error');
//         return Text('error');
//       }
//     }
//   )
//         )
// );
//
//
//     }


        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/burger.svg',
                    semanticsLabel: 'Icon burger',
                    height: 12.0),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //ListView(
                children: [
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 47),
                  ),
                  Expanded(
                      child: SingleChildScrollView(

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: [
                                Container(
                                  width: 284,
                                  margin: const EdgeInsets.only(
                                      bottom: 58),
                                  child: const TitlePage(
                                      title: 'главная'),
                                ),

                                Container (
                                    width: 284,
                                    margin: const EdgeInsets.only(top: 100, bottom: 100),
                                    child: (
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
                                        )
                                    )

                                ),
                                Container (
                                  //constraints: BoxConstraints(maxWidth: 284, maxHeight: 400),
                                  // width: MediaQuery.of(context).size.width,
                                  width: 284,
                                  height: 200,
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                  color: const Color(0xFF181C33),
                                  child: Banners(),
                                ),

                                const TitlePage(title: 'мы в соцсетях'),

                                Socials(),



                              ]
                          )
                      )
                  ),


                ]
            ),

          ),

          //body: Home(),

          drawer: NavDrawer(),



        ),



    );
  }
}

// Future<UsersList> getUsersList() async {
// //   getUsersList() async {
//   print('get users-list home');
//   // const url = 'https://about.google/static/data/locations.json';
//   //const url = 'http://localhost/test/users.json';
//   const url = 'http://localhost/test/users_list.php';
//   final response = await http.post(Uri.parse(url));
// print(response.body);
// print(json.decode(response.body));
// // var results = json.decode(response.body);
// // print(UsersList.fromJson(json.decode(response.body))); //error
//   if(response.statusCode == 200) {
//     print(response.statusCode);
//     // User user = User.fromJson(results);
//     // print(user);
//
//
//     return UsersList.fromJson(json.decode(response.body));
//
//
//     //return UsersList.fromJson(results);
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
//
//}
// Future<UsersList> readJsonUsers() async {
//   final String response = await rootBundle.loadString('assets/users.json');
//   final data = await json.decode(response);
//   return UsersList.fromJson(json.decode(response));
//
// }