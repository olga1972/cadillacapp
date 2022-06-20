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

import '../NavDrawerAdmin.dart';
import 'edit.dart';
import 'gift.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,
      //initialRoute: '/account',

      routes: {
        '/home': (context) => HomeAdmin(),
        // '/account': (context) => Account(currentUser: currentUser,),
        '/members': (context) => Members(),
        '/news': (context) => const News(),
        // '/shop': (context) => Shop(),
        '/partners': (context) => Partners(),
        '/contacts': (context) => Contacts(),
        '/gift': (context) => const Gift(),
        // '/test': (context) => Test()

      },

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2C335E),
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
              }
          ),
        ),


        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //ListView(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container (
                //       width: 160,
                //       margin: const EdgeInsets.only(right: 18.0, ),
                //       child: Text('Редактировать рекламу',
                //         textAlign: TextAlign.left,
                //
                //         style: TextStyle(
                //
                //           fontSize: 14.0,
                //           fontWeight: FontWeight
                //               .normal,
                //           fontFamily: 'CadillacSans',
                //           color: Colors.white,
                //           //height: 1.4, //line-height : font-size
                //         ),
                //       ),
                //     ),
                //
                //     IconButton(
                //       alignment: Alignment.centerLeft,
                //       padding: const EdgeInsets.all(0),
                //       iconSize: 22.0,
                //       icon: SvgPicture.asset(
                //         'assets/images/edit.svg',
                //         semanticsLabel: 'Icon edit',
                //         height: 15.0,
                //       ),
                //       onPressed: () {
                //         Route route = MaterialPageRoute(
                //             builder: (context) => Edit());
                //         Navigator.push(context,route);
                //       },
                //     ),
                //   ]
                // ),



                // Container(
                //   width: 284,
                //   margin: const EdgeInsets.only(
                //       top: 10, bottom: 30),
                // ),
                Expanded(
                    child: SingleChildScrollView(

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container (
                                      width: 160,
                                      margin: const EdgeInsets.only(right: 18.0, ),
                                      child: Text('Редактировать рекламу',
                                        textAlign: TextAlign.left,

                                        style: TextStyle(

                                          fontSize: 14.0,
                                          fontWeight: FontWeight
                                              .normal,
                                          fontFamily: 'CadillacSans',
                                          color: Colors.white,
                                          //height: 1.4, //line-height : font-size
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 22.0,
                                      icon: SvgPicture.asset(
                                        'assets/images/edit.svg',
                                        semanticsLabel: 'Icon edit',
                                        height: 15.0,
                                      ),
                                      onPressed: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) => Edit());
                                        Navigator.push(context,route);
                                      },
                                    ),
                                  ]
                              ),
                              Container(
                                width: 284,
                                margin: const EdgeInsets.only(
                                    bottom: 20, top: 40),
                                child: const TitlePage(
                                    title: 'главная'),
                              ),

                              Container (
                                  width: 284,
                                  margin: const EdgeInsets.only(top: 100, bottom: 40),
                                  child: (
                                      Text('Здесь вы можете размещать \nи редактировать рекламу'.toUpperCase(),
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

        drawer: NavDrawerAdmin(),



      ),



    );
  }
}

