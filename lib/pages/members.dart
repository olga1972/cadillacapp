import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';

import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/bannersList.dart';

class Members extends StatelessWidget {
  Members({Key? key}) : super(key: key);

  final List<String> users = <String>["денис антонов", "денис антонов", "денис антонов", "денис антонов", "денис антонов", "денис антонов"];

  @override
  Widget build(BuildContext context) {
    // Widget mainWidget = const Members();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/home',
        routes: {
          '/home': (context) => const Home(),
          // '/account': (context) => Account(),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),

        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
          ),

          // body: mainWidget,
          body: Center (
              child: Container (
                  width: 284,

                  child: Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container (
                          margin: const EdgeInsets.only(bottom: 20),
                          child:
                          const TitlePage(title: 'члены автоклуба'),
                        ),
                        Container (
                          height: 780,
                          child: ListView.builder (
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              // padding: const EdgeInsets.only(top: 38, bottom: 10),
                              itemCount: users.length,
                              // itemBuilder: (BuildContext context, int index) {
                              //   return Text(users[index], style: TextStyle(fontSize: 22));
                              // }
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width: 284,
                                    // height: 166,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    decoration:  BoxDecoration(
                                      color: const Color(0xFFE4E6FF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    child: Column (
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(users[index].toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'CadillacSans',
                                                  color: Colors.black,
                                                  height: 1.7, //line-height / font-size
                                                )
                                            ),
                                          ),

                                          Container (
                                            margin: const EdgeInsets.only(bottom: 10.0),
                                            child: Row (
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children:  const [
                                                CircleAvatar (
                                                  radius: 48,
                                                  child: Image(
                                                    image: NetworkImage('assets/images/avatar.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Image(
                                                  image: NetworkImage('assets/images/cadillac-xt6.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ],
                                            ),
                                          ),

                                          Row (
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text('cadillac xt6'.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'CadillacSans',
                                                      color: Color(0xFF12141F),
                                                      // height: 1.7, //line-height / font-size
                                                    )
                                                ),
                                                Container (
                                                  // height: 15,

                                                  margin: const EdgeInsets.only(left: 42.0, ),
                                                  alignment: Alignment.centerLeft,
                                                  child: SvgPicture.network(
                                                      'assets/images/cadillac.svg',
                                                      semanticsLabel: 'Icon car',
                                                      height: 15.0
                                                  ),
                                                ),

                                              ]
                                          )
                                        ]
                                    )
                                );
                              }
                          ),
                        )

                      ]
                  )
              )
          ),

          drawer: const NavDrawer(),
        )
    );
  }
}