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

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/news.dart';
import '../variables.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  late Future<NewsList> newsList;

  @override
  void initState() {
    super.initState();
    newsList = getNewsList();
    // setState(() {
    //   _items = data["items"];
    // });
  }

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

          body: Center (
              child: ListView (
                  children: [
                    Center (
                        child: Container (
                            child: Column (
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container (
                                    width: 320,
                                    height: 830,
                                    child: FutureBuilder<NewsList>(
                                        future: newsList,
                                        builder: (context, snapshot) {

                                        var news = snapshot.data?.news;
                                        final List<New>? newsList = snapshot.data?.news;
                                        print('news');
                                        print(newsList);

                                        if (snapshot.hasData) {
                                          return Center(
                                            child: Container(
                                            width: 320,
                                            height: 860,
                                              child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                  bottom: 20),
                                                  child:
                                                  const TitlePage(
                                                  title: 'клубные новости'),
                                                ),
                                                Container(
                                                  height: 780,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                                    itemCount: snapshot.data?.news?.length,
                                                    itemBuilder: (context, index) {
                                                          return Container(
                                                          width: 320,
                                                          // height: 166,
                                                          margin: const EdgeInsets.only(top: 10, bottom: 10,),

                                                          child: Column (
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Stack(
                                                                          clipBehavior: Clip.none,
                                                                          children: [
                                                                            Container(
                                                                              margin: const EdgeInsets.only(bottom: 10,),
                                                                              child: Text('${snapshot.data?.news?[index]?.newsDate}',
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

                                                                          ]
                                                                      )

                                                                    ]
                                                                ),

                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Stack(
                                                                          clipBehavior: Clip.none,
                                                                          children: [
                                                                            Text.rich(
                                                                              TextSpan (
                                                                                  text: '${snapshot.data?.news?[index]?.newsName}'.toUpperCase(),
                                                                                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: Colors.white, height: 1.5),
                                                                                  children: <InlineSpan>[
                                                                                    TextSpan(
                                                                                      text: '\ncadillac escalada'.toUpperCase(),
                                                                                      style: const TextStyle(fontSize: 24,fontWeight: FontWeight.normal, color: Colors.white, height: 1.4),
                                                                                    )
                                                                                  ]
                                                                              ),
                                                                            ),

                                                                          ]

                                                                      ),
                                                                    ]
                                                                ),


                                                                Container (
                                                                  margin: const EdgeInsets.only(bottom: 10.0, top: 10),
                                                                  child: Image.asset(
                                                                    'assets/images/cadillac-escalada.png',
                                                                    fit: BoxFit.fill,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets.only(bottom: 10,),
                                                                  child: Text('${snapshot.data?.news?[index]?.newsDescr}',
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
                    );
                }
                else if (snapshot.hasError) {
                  return const Text('Error');
                }
                  return const Center(child: CircularProgressIndicator());

                }
              )
          )

        ]
              ),

            ),
          )
       ]
    )
          ),

          drawer: NavDrawer(),
        ),

    );
  }
}

Future<NewsList> getNewsList() async {
  print('getNewsList');
  const url = baseUrl + '/test/news_list.php';
  final response = await http.get(Uri.parse(url));
  print('response members getUserLists');
  print(response.body);
  if(response.statusCode == 200) {
    return NewsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}