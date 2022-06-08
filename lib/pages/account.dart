import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';


import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../models/users.dart';
//import '../../models/user2.dart';


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
import 'edit.dart';

class Account extends StatelessWidget {
// class Account extends StatefulWidget {
  // final User currentUser;

  Account({Key? key}) : super(key: key);


  //final List<String>? _allowedExtensions = ['png', 'pdf'];

  late dynamic userId = "1111";


  // currentUser<User> = User();

//   @override
//   _AccountState createState() => _AccountState();
// }

  // class _AccountState extends State<Account> {
  // // get currentUser => null;
  // //late dynamic userId;
  // late bool _loading;





  //get userId => null;
  //set userId = userId;
  //late User _user;
  //late Future<User> user;
  // late Future<UsersList> usersList;

  // @override
  // void initState() {
  //   super.initState();
  //   print('init state account');
  //   _loading = false;
  //   //userId = this.userId;
  //   //
  //   // print('userId: ${userId}'); //null
  //
  //   //_user = currentUser;
  //   // var user = getUser(userId);
  //   // print(user);
  //
  //
  //
  // // var usersList = getUsersList();
  // // print("usersList: ${getUsersList()}");
  // // print("usersList: ${getUser(userId)}");
  //
  // }



  //get user => null;

    // var userBox = Hive.box<User>(HiveBoxes.user);

  @override
  Widget build(BuildContext context) {
    // var productsList = readJson();
    // var user = readJsonUser(); зависает страница
    // final userBox = Hive.box<User>(HiveBoxes.user);
    //print('id3: $userUuId');
    dynamic user;
    //dynamic currentUser;
    print('user account');
    print('load');
    //print(userId);

    print('userId: $userId');

    //User currentUser = User( email: '', birthday: '', userId: userId, phone: '', username: '' );
    user = getUser();
    print(user.runtimeType);

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
          '/shop': (context) => Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),
          '/gift': (context) => const Gift(),

        },

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.network('assets/images/burger.svg'),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

        // body:  FutureBuilder<User>(
        //     future: user,
        //     builder: (context, snapshot) {
        //       print('snapshot.data account: $snapshot.data');
        //       if (snapshot.hasData) {
        //         return Card(
        //                 child: ListTile(
        //                   title: Text('${snapshot.data?.username}'),
        //                   // title: Text('title'),
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

          body: FutureBuilder<User>(
              future: user,
              builder: (context, snapshot) {
                // print('snapshot.data account: ${snapshot.data}');  //error json?
                if (snapshot.hasData) {
                  return Center(
                      child: Container(
                          width: 284,

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: SingleChildScrollView(
                                        child: Column(
                                            children: [
                                              const TitlePage(
                                                  title: 'мой аккаут \nавтоклуба cadillac'),

                                              Container(
                                                // height: 100,
                                                  margin: const EdgeInsets.only(
                                                      top: 43.0, bottom: 43.0),
                                                  color: Colors.transparent,
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Column(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,

                                                                children: [
                                                                  Container(
                                                                    height: 36,
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                      right: 18.0,),
                                                                    alignment: Alignment
                                                                        .centerLeft,
                                                                    child: SvgPicture
                                                                        .network(
                                                                        'assets/images/account.svg',
                                                                        semanticsLabel: 'Icon author',
                                                                        height: 22.0
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      '${snapshot
                                                                          .data
                                                                          ?.username}'
                                                                          .toUpperCase(),
                                                                      textAlign: TextAlign
                                                                          .center,
                                                                      style: const TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight: FontWeight
                                                                            .normal,
                                                                        fontFamily: 'CadillacSans',
                                                                        color: Colors
                                                                            .white,
                                                                        height: 1.4, //line-height : font-size
                                                                      )
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                mainAxisSize: MainAxisSize
                                                                    .min,
                                                                children: [
                                                                  Container(
                                                                      height: 36,
                                                                      //margin: const EdgeInsets.only(right: 18.0, ),
                                                                      alignment: Alignment
                                                                          .centerLeft,
                                                                      child: IconButton(
                                                                        alignment: Alignment
                                                                            .centerLeft,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                        iconSize: 22.0,
                                                                        icon: SvgPicture
                                                                            .network(
                                                                          'assets/images/gift.svg',
                                                                          semanticsLabel: 'Icon gift',
                                                                          height: 22.0,

                                                                        ),
                                                                        onPressed: () {
                                                                          Route route = MaterialPageRoute(
                                                                              builder: (
                                                                                  context) => const Gift());
                                                                          Navigator
                                                                              .push(
                                                                              context,
                                                                              route);
                                                                        },
                                                                      )
                                                                  ),

                                                                  Text(
                                                                      '${snapshot
                                                                          .data
                                                                          ?.email}'
                                                                          .toUpperCase(),
                                                                      textAlign: TextAlign
                                                                          .left,
                                                                      style: const TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight: FontWeight
                                                                            .normal,
                                                                        fontFamily: 'CadillacSans',
                                                                        color: Colors
                                                                            .white,
                                                                        height: 1.4, //line-height : font-size
                                                                      )
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Container(
                                                                      height: 36,
                                                                      // margin: const EdgeInsets.only(right: 18.0, ),
                                                                      alignment: Alignment
                                                                          .centerLeft,
                                                                      child: IconButton(
                                                                        alignment: Alignment
                                                                            .centerLeft,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                        iconSize: 22.0,
                                                                        icon: SvgPicture
                                                                            .network(

                                                                          'assets/images/edit.svg',
                                                                          semanticsLabel: 'Icon edit',
                                                                          height: 15.0,

                                                                        ),
                                                                        onPressed: () {
                                                                          Route route = MaterialPageRoute(
                                                                              builder: (
                                                                                  context) =>
                                                                                  Edit());
                                                                          Navigator
                                                                              .push(
                                                                              context,
                                                                              route);
                                                                        },
                                                                      )

                                                                  ),
                                                                  const Text(
                                                                    'Изменить данные',
                                                                    textAlign: TextAlign
                                                                        .center,
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight
                                                                          .normal,
                                                                      fontFamily: 'CadillacSans',
                                                                      color: Color(
                                                                          0xFF515569),
                                                                      height: 1.4, //line-height : font-size
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ]
                                                        ),

                                                        CircleAvatar(
                                                          radius: 48,
                                                          child: Image(
                                                            // width: 96,
                                                            // height: 96,
                                                            image: NetworkImage(
                                                              'assets/images/avatar.png',),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )

                                                      ]

                                                  )
                                              ),

                                              Text('ваш именной номер'
                                                  .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.white,
                                                    height: 1.4, //line-height : font-size
                                                  )
                                              ),
                                              Container(
                                                width: 284,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  color: const Color(
                                                      0xFF515569),
                                                ),
                                                padding: const EdgeInsets.all(
                                                    15),
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 25),
                                                child: const Text(
                                                    '379379379379',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontFamily: 'CadillacSans',
                                                      color: Colors.white,
                                                      // height: 1.4, //line-height : font-size
                                                    )
                                                ),
                                              ),
                                              Text('ваш автомобиль'
                                                  .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.white,
                                                    height: 1.5, //line-height : font-size
                                                  )
                                              ),
                                              // Text('${snapshot.data?.car}'.toUpperCase(),
                                              Text('cadillac'.toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.white,
                                                    height: 1.17, //line-height : font-size
                                                  )
                                              ),

                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  padding: EdgeInsets.zero,
                                                  margin: const EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 30,
                                                      left: 0,
                                                      right: 0),
                                                  color: const Color(
                                                      0xFF181C33),
                                                  child: Gallery()
                                              ),
                                            ]
                                        )
                                    )
                                )
                              ]
                          )
                      )
                  );
                } else if (snapshot.hasError) {
                    return const Text('Error');
                 }
                  return const Center(child: CircularProgressIndicator());
               },

          ),

          drawer: NavDrawer(),
        ),

    );
  }

  // Future<List<User>> getUser(userId) async {



}

Future<User> getUser() async {
  print('getUser');
  // print('userId: $userId');

  String apiurl = "http://localhost/test/get_user.php"; // get jsonplaceholder
  // final response = await http.post(Uri.parse(apiurl), body:{'userId': userId});
  var birthday = '111';
  var phone = '111';
  var email= '111';
  final response = await http.post(Uri.parse(apiurl), body:{'phone': phone,'email': email, 'birthday': birthday},headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});

  if (response.statusCode == 200) {
    print(response.statusCode);
    print(response.body);
    final userJson = json.decode(response.body);
    //final userJson = response.body;
    print('userJson');
    print(userJson);
    return User.fromJson(userJson);

    //return userJson.map((json) => User.fromJson(userJson));
  } else {
    throw Exception('Error fetching users');
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