import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';


import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../models/user2.dart';
//import '../../models/users.dart';


import 'package:cadillac/variables.dart';
import 'dart:async';
import 'dart:io';


import 'package:cadillac/pages/home.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/gallery.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:card_swiper/card_swiper.dart';

import '../models/products.dart';
import 'gift.dart';


class Account extends StatefulWidget {
  // final User currentUser;

  Account({Key? key, required this.userId}) : super(key: key);

  final String userId;

  // currentUser<User> = User();

  @override
  _AccountState createState() => _AccountState();
}

  class _AccountState extends State<Account> {
  get currentUser => null;

  late bool _loading;

  //get userId => null;
  //set userId = userId;
  //late User _user;
  //late Future<User> user;
  // late Future<UsersList> usersList;

  @override
  void initState() {
  print('initstate account');
  _loading = false;
  //var userId = userId;

  super.initState();

  print('userId: $this.userId');
  //_user = currentUser;

  var user = getUser();
  print(user);
  // usersList = getUsersList();
  // print("usersList: ${getUsersList()}");
    //print("usersList: ${getUser()}");

  }


  //get user => null;

    // var userBox = Hive.box<User>(HiveBoxes.user);

  @override
  Widget build(BuildContext context) {
    // var productsList = readJson();
    // var user = readJsonUser(); зависает страница
    // final userBox = Hive.box<User>(HiveBoxes.user);
    //print('id3: $userUuId');
    //dynamic currentUser;
    print('user account');



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
          '/shop': (context) => const Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),
          '/gift': (context) => const Gift(),

        },

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
          ),

        // body:  FutureBuilder<User>(
        //     //future: User,
        //     builder: (context, snapshot) {
        //       print('snapshot.data: $snapshot');
        //       if (snapshot.hasData) {
        //         return Card(
        //                 child: ListTile(
        //                   // title: Text('${snapshot.data?.username}'),
        //                   title: Text('title'),
        //                   subtitle:
        //                   // Text('${snapshot.data?.email}'),
        //                   Text('title'),
        //                   // leading: Image.network(
        //                   //     '${snapshot.data?.photo}'),
        //                   isThreeLine: true,
        //                 ),
        //               );
        //             //});
        //       } else if (snapshot.hasError) {
        //         print(snapshot.data);
        //         return const Text('Error');
        //       }
        //       return const Center(child: CircularProgressIndicator());
        //     },
        //   ),

          body: Center (
            child: Container (
              width: 284,

              child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column (
                          children: [
                          const TitlePage(title: 'мой аккаут \nавтоклуба cadillac'),

                          Container(
                            // height: 100,
                              margin: const EdgeInsets.only(top: 43.0, bottom: 43.0),
                              color: Colors.transparent,
                              child: Row (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column (
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row (
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Container (
                                                height: 36,
                                                margin: const EdgeInsets.only(right: 18.0, ),
                                                alignment: Alignment.centerLeft,
                                                child: SvgPicture.network(
                                                    'assets/images/account.svg',
                                                    semanticsLabel: 'Icon author',
                                                    height: 22.0
                                                ),
                                              ),
                                              Text('Денис'.toUpperCase(),
                                              // Text('${currentUser.username}'.toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.white,
                                                    height: 1.4, //line-height : font-size
                                                  )
                                              )
                                            ],
                                          ),
                                          Row (
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container (
                                                height: 36,
                                                //margin: const EdgeInsets.only(right: 18.0, ),
                                                alignment: Alignment.centerLeft,
                                                child: IconButton (
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(0),
                                                  iconSize: 22.0,
                                                  icon: SvgPicture.network(

                                                      'assets/images/gift.svg',
                                                      semanticsLabel: 'Icon gift',
                                                      height: 22.0,

                                                  ),
                                                  onPressed: () {
                                                    Route route = MaterialPageRoute(builder: (context) => const Gift());
                                                    Navigator.push(context, route);
                                                  },
                                                )
                                              ),

                                              // Text('${currentUser.birthday}'.toUpperCase(),
                                              Text('24.08.1996'.toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.white,
                                                    height: 1.4, //line-height : font-size
                                                  )
                                              )
                                            ],
                                          ),
                                          Row (
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container (
                                                height: 36,
                                                margin: const EdgeInsets.only(right: 18.0, ),
                                                alignment: Alignment.centerLeft,
                                                child: SvgPicture.network(
                                                    'assets/images/edit.svg',
                                                    semanticsLabel: 'Icon edit',
                                                    height: 15.0,
                                                    color: const Color(0xFF515569)
                                                ),
                                              ),
                                              const Text('Изменить данные',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'CadillacSans',
                                                  color: Color(0xFF515569),
                                                  height: 1.4, //line-height : font-size
                                                ),
                                              )
                                            ],
                                          ),
                                        ]
                                    ),

                                    CircleAvatar (
                                      radius: 48,
                                      child: Image(
                                        // width: 96,
                                        // height: 96,
                                        image:  NetworkImage('assets/images/avatar.png',),
                                        fit: BoxFit.fill,
                                      ),
                                    )

                                  ]

                              )
                          ),

                          Text('ваш именной номер'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'CadillacSans',
                                color: Colors.white,
                                height: 1.4, //line-height : font-size
                              )
                          ),
                          Container (
                            width: 284,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF515569),
                            ),
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 10, bottom: 25),
                            child: const Text('379379379379',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'CadillacSans',
                                  color: Colors.white,
                                  // height: 1.4, //line-height : font-size
                                )
                            ),
                          ),
                          Text('ваш автомобиль'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'CadillacSans',
                                color: Colors.white,
                                height: 1.5, //line-height : font-size
                              )
                          ),
                          // Text('${currentUser.car}'.toUpperCase(),
                          Text('cadillac'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'CadillacSans',
                                color: Colors.white,
                                height: 1.17, //line-height : font-size
                              )
                          ),

                          Container (
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              padding: EdgeInsets.zero,
                              margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                              color: const Color(0xFF181C33),
                              child: Gallery()
                        ),
                          ]
                        )
                      )
                    )
                 ]
              )
            )
          ),

          drawer: NavDrawer(),
        ),

    );
  }

  Future<List<User>> getUser() async {
    final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }


}

// addInfoUser() async {
//   dynamic phone='';
//   dynamic email ='';
//   dynamic userId ='';
//
//   String apiurl = "http://localhost/test/create.php";
//   var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
//     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
//   // var response = await http.post(Uri.parse(apiurl));
//   print(response.body);
//   if(response.statusCode == 200){
//     print('success');
//     // var uuid = const Uuid();
//     // var id = uuid.v1();
//     return response.body;
//     // setState(() {
//     //   showprogress = false; //don't show progress indicator
//     //   error = true;
//     //   errormsg = jsondata["message"];
//     // });
//
//   }else{
//     print('error response');
//   }
//   //return id;
// }