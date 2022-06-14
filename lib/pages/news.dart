import 'package:flutter/material.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';

import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/bannersList.dart';
import 'package:flutter_svg/svg.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);


  // get userId => null;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        //initialRoute: 'news',

        //  routes: {
        //   '/home': (context) => const Home(),
        //   // '/account': (context) => Account(userId: userId,),
        //   // '/members': (context) => Members(),
        //   '/news': (context) => const News(),
        //   '/shop': (context) => const Shop(),
        //   '/partners': (context) => Partners(),
        //   '/contacts': (context) => Contacts(),
        //
        // },

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
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

          body: Center (
              child: ListView (
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center (
                          child: Container (
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container (
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: const TitlePage(title: 'клубные новости'),
                                  ),

                                  Container (
                                    height: 680,
                                    child: ListView.builder (
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                        itemCount: 3,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                              width: 284,
                                              // height: 166,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),

                                              child: Column (
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.only(bottom: 10),
                                                      child: const Text('14 апреля 2022',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 32.0,
                                                            fontWeight: FontWeight.normal,
                                                            fontFamily: 'CadillacSans',
                                                            color: Color(0xFF8F97BF),
                                                            height: 1.7, //line-height / font-size
                                                          )
                                                      ),
                                                    ),
                                                    Text.rich(
                                                      TextSpan (
                                                          text: 'презентация нового'.toUpperCase(),
                                                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: Colors.white, height: 1.5),
                                                          children: <InlineSpan>[
                                                            TextSpan(
                                                              text: '\ncadillac escalada'.toUpperCase(),
                                                              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.normal, color: Colors.white, height: 1.4),
                                                            )
                                                          ]
                                                      ),
                                                    ),


                                                    Container (
                                                      margin: const EdgeInsets.only(bottom: 10.0, top: 10),
                                                      child: Image.asset(
                                                        'assets/images/cadillac-escalada.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),



                                                  ]
                                              )
                                          );
                                        }
                                    ),
                                  ),

                                  // Container (
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height: 200,
                                  //   padding: EdgeInsets.zero,
                                  //   margin: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                                  //   color: Color(0xFF181C33),
                                  //   child: Banners(),
                                  // ),
                                ]
                              )

                          )
                       )

                      ]
                  )

              //)
          //)
          ),
              //         ]
              //     )
              // )
          //),


          //),

          drawer: NavDrawer(),
        ),

    );
  }
}