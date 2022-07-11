import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/src/material/input_border.dart';
//import 'package:cadillac/NavBar.dart';

//import 'package:cadillac/CustomAppBar.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
// import 'package:cadillac/widgets/bannersList.dart';



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../models/banners.dart';
import '../variables.dart';
import 'gift.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<BannersList> bannersList;

  //late Future<Partner> partners;
  late String bannerId;
  //late Future<ProductsList> productsList;
  bool isLoadedImage = false;
  late File _image;
  late String currentBannerId;

  @override
  void initState() {
    super.initState();
    bannersList = getBannersList();
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
          '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser,),
          '/members': (context) => const Members(),
          '/news': (context) => const News(),
          // '/shop': (context) => Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          '/gift': (context) => const Gift(),
          // '/test': (context) => Test()

        },

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
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                                  height: 107,
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                  color: const Color(0xFF181C33),
                                  // child: AdsBanners(),
                                    child: FutureBuilder<BannersList>(
                                        future: bannersList,
                                        builder: (context, snapshot) {

                                          var banners = snapshot.data?.banners;
                                          List<AdsBanner>? bannersList = snapshot.data?.banners;
                                          print('Banners');
                                          print(bannersList);

                                          if (snapshot.connectionState !=
                                              ConnectionState.done) {
                                            return const Center(
                                                child: CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                                child: Text(snapshot.error.toString()));
                                          }

                                          if (snapshot.hasData) {
                                            int countImages = snapshot.data
                                            !.banners.length;
                                            return Swiper(
                                              //containerHeight: 82,
                                              containerWidth: 284,
                                              // layout: SwiperLayout.CUSTOM,
                                              // customLayoutOption:
                                              // CustomLayoutOption(startIndex: -1, stateCount: 2)
                                              //   ..addTranslate([
                                              //     const Offset(-28.0, 0.0),
                                              //     const Offset(256.0, 0.0),
                                              //     // const Offset(304.0, 0.0)
                                              //   ]),

                                              viewportFraction: 1,
                                              //itemHeight: 82,
                                              itemWidth: 284,
                                              autoplay: true,
                                              itemCount: countImages,
                                              // outer: true,
                                              itemBuilder: (BuildContext context, int index) {
                                                late Uint8List bytes;

                                                var pathEncode = snapshot.data?.banners[index].path;
                                                var decode64 = base64.decode(pathEncode!);

                                                bytes = decode64;


                                                if (snapshot.data?.banners[index].path != null) {
                                                  isLoadedImage = true;

                                                } else {
                                                  isLoadedImage = false;
                                                }
                                                return Container (
                                                    width: 284,
                                                    height: 107,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0XffE4E6FF),
                                                      borderRadius: BorderRadius.all(Radius
                                                          .circular(20.0)),
                                                    ),
                                                    margin: const EdgeInsets.only(bottom: 10.0, top: 10, left: 10,right: 10),
                                                    child: isLoadedImage ?
                                                    Image.memory(base64.decode(snapshot.data?.banners[index].path ?? ''), fit: BoxFit.cover, width: 284, height: 107) :
                                                    const Text('no image',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: 'CadillacSans',
                                                          color: Color(0xFF8F97BF),
                                                          height: 1.7, //line-height / font-size
                                                        ))
                                                );
                                              },
                                              // control: SwiperControl(),
                                            );
                                          }

                                          return const Center(child: Text('no data'));
                                        }
                                    )
                                ),

                                const TitlePage(title: 'мы в соцсетях'),

                                const Socials(),



                              ]
                          )
                      )
                  ),


                ]
            ),

          ),

          //body: Home(),

          drawer: const NavDrawer(),



        ),



    );
  }
}

Future<BannersList> getBannersList() async {
  print('getBannersList');
  const url = baseUrl + '/test/banners_list.php';
  final response = await http.get(Uri.parse(url));
  print('response getBannersList');
  print(response.body);
  if(response.statusCode == 200) {
    return BannersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}