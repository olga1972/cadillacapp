import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/shop.dart';

import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/partnersList.dart';
import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';


class PartnersAdmin extends StatelessWidget {
  PartnersAdmin({Key? key}) : super(key: key);

  final List<String> partners = <String>[
    "assets/images/golf_club.png",
    "assets/images/image16.png",
    "assets/images/image18.png",
    "assets/images/image19.png",
    "assets/images/image17.png",
  ];

  get currentUser => null;



  @override
  Widget build(BuildContext context) {
    // Widget mainWidget = const Members();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          // '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),

        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          body: Center(
            child: ListView (
                children: [
                  Center(
                    child: Container(

                      //   )
                      // )
                      // Container(
                      //   width: 284,
                      //   margin: const EdgeInsets.only(
                      //       top: 10, bottom: 47),
                      // ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment
                          //     .center,
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              Container (
                                width: 310,
                                margin: const EdgeInsets.only(bottom: 40),
                                child:
                                const TitlePage(title: 'партнеры автоклуба\ncadillac'),
                              ),
                              Container (
                                  width: 310,
                                  height: 960,
                                  child: ListView.builder (
                                    // scrollDirection: Axis.vertical,
                                    // shrinkWrap: true,
                                      itemCount: partners.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container (
                                          width: 284,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(bottom: 30),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                  partners[index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(left: 15),
                                                child: IconButton(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding: const EdgeInsets.all(0),
                                                  iconSize: 20.0,
                                                  icon: SvgPicture
                                                      .asset(
                                                    'assets/images/delete.svg',
                                                    semanticsLabel: 'Icon delete',
                                                    height: 20.0,

                                                  ),
                                                  onPressed: () {
                                                    //   Route route = MaterialPageRoute(
                                                    //       builder: (
                                                    //           context) => const Gift());
                                                    //   Navigator
                                                    //       .push(
                                                    //       context,
                                                    //       route);
                                                  },
                                                )
                                              )


                                            ]
                                          )
                                        );

                                      }
                                  )
                                ),
                              Container(
                                  width: 310,
                                  margin: const EdgeInsets.only(left: 15),
                                  alignment: Alignment(1, 1),
                                  child: IconButton(
                                    alignment: Alignment
                                        .centerLeft,
                                    padding: const EdgeInsets.all(0),
                                    iconSize: 20.0,
                                    icon: SvgPicture
                                        .asset(
                                      'assets/images/add.svg',
                                      semanticsLabel: 'Icon add',
                                      height: 20.0,

                                    ),
                                    onPressed: () {
                                      //   Route route = MaterialPageRoute(
                                      //       builder: (
                                      //           context) => const Gift());
                                      //   Navigator
                                      //       .push(
                                      //       context,
                                      //       route);
                                    },
                                  )
                              )
                            ]
                        )

                    ),
                  ),
                ]
            ),
          ),

          drawer: NavDrawerAdmin(),
        )
    );
  }
}