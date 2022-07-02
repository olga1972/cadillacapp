import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
import 'package:cadillac/pages/addBanners.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
// import 'package:cadillac/widgets/bannersList.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/models/users.dart';
import 'package:cadillac/models/products.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../models/banners.dart';
import '../models/news.dart';
import '../variables.dart';

import 'edit.dart';
import 'gift.dart';
import 'newsAdmin.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int selectedIndex = 1;

  late Future<BannersList> bannersList;
  late Future<AdsBanner> banners;
  late File _img;
  late String path = "assets/images/avatar.png";

  late dynamic length;

  @override
  void initState() {
    super.initState();
    bannersList = getBannersList();

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
        '/newsAdmin': (context) => const NewsAdmin(),
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

        body: Center (
            // child: ListView (
            //     children: [
            //       Center (
            //         child: Container (
          child: Column (
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded (
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container (
                                width: 160,
                                margin: const EdgeInsets.only(right: 18.0),
                                child: const Text('Редактировать рекламу',
                                textAlign: TextAlign.right,
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
                                // Route route = MaterialPageRoute(
                                //     builder: (context) => Edit());
                                // Navigator.push(context,route);
                                },
                              ),
                            ]
                          ),
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
                          margin: const EdgeInsets.only(top: 80, ),
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
                          width: 320,
                          //height: 830,
                          child: FutureBuilder<BannersList>(
                            future: bannersList,
                            builder: (context, snapshot) {

                            var banners = snapshot.data?.banners;
                            List<AdsBanner>? bannersList = snapshot.data?.banners;
                            print(bannersList);

                            if (snapshot.hasData) {
                              return Center(
                                  child: Container(
                                      width: 320,
                                      //height: 860,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Container(
                                                height: 340,
                                                child: Swiper(
                                                    containerWidth: 320,
                                                    viewportFraction: 1.0,
                                                    itemHeight: 92,
                                                    itemWidth: 284,
                                                    // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                                    // itemCount: snapshot.data?.banners.length,
                                                    itemCount: 2,
                                                    itemBuilder: (context, index) {
                                                      String currentBannerId;
                                                      _img = File('${snapshot.data?.banners?[index].path}');
                                                      return Container(
                                                          width: 320,
                                                          // height: 166,
                                                          margin: const EdgeInsets.only(top: 10,bottom: 10,),

                                                          child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Stack(
                                                                    alignment: Alignment.centerRight,
                                                                    clipBehavior: Clip
                                                                        .none,
                                                                    children: [



                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .only(bottom: 10.0, top: 10, right: 50, left: 20),
                                                                  child: Image.file(_img, fit: BoxFit.fill, width: 285, height: 140,
                                                                  ),
                                                                ),
                                                                Column (
                                                                  children: [
                                                                    Container (
                                                                      margin: EdgeInsets.only(bottom: 30.0),
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          confirmDialog(context);
                                                                          setState(() {
                                                                            // устанавливаем индекс выделенного элемента
                                                                            selectedIndex = index;
                                                                          });
                                                                          print(snapshot.data?.banners?[selectedIndex].bannerId);
                                                                          var currentBannerId = snapshot.data?.banners?[selectedIndex].bannerId;
                                                                          deleteBanner(currentBannerId);

                                                                          Route route = MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  HomeAdmin());
                                                                          Navigator.push(context,route);

                                                                        },
                                                                        child: SvgPicture.asset(
                                                                          'assets/images/delete.svg',
                                                                          semanticsLabel: 'Icon delete',
                                                                          height: 20.0,


                                                                        ),
                                                                      ),
                                                                    ),


                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        Route route = MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                AddBanners());
                                                                        Navigator.push(context,route);
                                                                      },
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        'assets/images/add.svg',
                                                                        semanticsLabel: 'Icon add',
                                                                        height: 20.0,

                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: false,
                                                                      child: FormBuilderTextField(
                                                                        name: 'currentBannerId',
                                                                        initialValue: '${snapshot.data?.banners?[selectedIndex].bannerId}',
                                                                        onSaved: (value) => currentBannerId = value!,
                                                                      ),
                                                                    ),
                                                                ]
                                                                ),


                                                              ]
                                                          )
                                                      ]
                                                      )

                                                      );
                                                    }
                                                )
                                            )
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
                              //           )
                              //       )
                              //     ]
                              // ),

                            ),
                          )
                                  ]
                                )
                            )


                )
              ]
            )
        ),
    //     body: Center(
    //           child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Expanded(
    //                 child: SingleChildScrollView(
    //
    //                     child: Column(
    //                     mainAxisAlignment: MainAxisAlignment
    //                         .center,
    //                     crossAxisAlignment: CrossAxisAlignment
    //                         .center,
    //                     children: [

    //
    //                         Container (
    //                             width: 320,
    //                             height: 830,
    //                             child: FutureBuilder<BannersList>(
    //                             future: bannersList,
    //                                 builder: (context, snapshot) {
    //
    //                             var banners = snapshot.data?.banners;
    //                             List<AdsBanner>? bannersList = snapshot.data?.banners;
    //                             print('news');
    //                             print(bannersList);
    //
    //                             if (snapshot.hasData) {
    //                               return Center(
    //                                   child: Container(
    //                                       width: 320,
    //                                       height: 860,
    //                                       child: Column(
    //                                           mainAxisAlignment: MainAxisAlignment
    //                                               .center,
    //                                           crossAxisAlignment: CrossAxisAlignment
    //                                               .center,
    //                                           children: [
    //                                             Container(
    //                                                 height: 740,
    //
    //                                                 child: Swiper(
    //                                                   //containerHeight: 160,
    //                                                   //containerWidth: 390,
    //                                                   layout: SwiperLayout
    //                                                       .CUSTOM,
    //                                                   customLayoutOption:
    //                                                   CustomLayoutOption(
    //                                                       startIndex: -1,
    //                                                       stateCount: 2)
    //                                                     ..addTranslate([
    //                                                       const Offset(
    //                                                           -28.0, 0.0),
    //                                                       const Offset(
    //                                                           256.0, 0.0),
    //                                                       // const Offset(304.0, 0.0)
    //                                                     ]),
    //
    //                                                   viewportFraction: 0.8,
    //                                                   itemHeight: 160,
    //                                                   itemWidth: 284,
    //                                                   // outer: true,
    //                                                   itemBuilder: (
    //                                                       BuildContext context,
    //                                                       int index) {
    //                                                     _img = File(
    //                                                         '${snapshot.data
    //                                                             ?.banners?[index]
    //                                                             .path}');
    //                                                     length =
    //                                                     snapshot.data?.banners
    //                                                         .length!;
    //                                                     return Container(
    //                                                       decoration: const BoxDecoration(
    //                                                         borderRadius: BorderRadius
    //                                                             .all(
    //                                                             Radius.circular(
    //                                                                 20)),
    //                                                       ),
    //                                                       margin: const EdgeInsets
    //                                                           .only(left: 10,
    //                                                           right: 10),
    //                                                       child: Image.file(
    //                                                         _img, width: 285,
    //                                                         height: 160,
    //                                                         // ${snapshot.data?.car}[index],
    //                                                         // centerSlice: Rect.fromPoints(const Offset(50.0, 0.0), const Offset(0, 0)),
    //                                                         fit: BoxFit.fill,
    //                                                         alignment: Alignment
    //                                                             .centerLeft,
    //                                                       ),
    //                                                     );
    //                                                   },
    //                                                   // autoplay: true,
    //                                                   itemCount: length,
    //                                                   // itemWidth: 285.0,
    //                                                 )
    //                                             ),
    //
    //                                             //   child: Stack (
    //                                             //
    //                                             //   //)
    //                                             //   // child: ListView.builder(
    //                                             //   //   scrollDirection: Axis.vertical,
    //                                             //   //   shrinkWrap: true,
    //                                             //   //   // padding: const EdgeInsets.only(top: 38, bottom: 10),
    //                                             //   //   itemCount: snapshot.data?.banners?.length,
    //                                             //   //   itemBuilder: (context, index) {
    //                                             //   //   String currentNewsId;
    //                                             //   // _img = File('${snapshot.data?.banners?[index].path}');
    //                                             //
    //                                             //     alignment: Alignment.centerRight,
    //                                             //     children: [
    //                                             //     Container (
    //                                             //     //constraints: BoxConstraints(maxWidth: 284, maxHeight: 400),
    //                                             //     // width: MediaQuery.of(context).size.width,
    //                                             //     width: 284,
    //                                             //     height: 200,
    //                                             //     padding: EdgeInsets.zero,
    //                                             //     margin: const EdgeInsets.only(top: 10, bottom: 30, left: 60, right: 70),
    //                                             //     color: const Color(0xFF181C33),
    //                                             //     // child: AdsBanners(),
    //                                             //     child: Column(
    //                                             //     children: [
    //                                             //     Swiper(
    //                                             //     containerWidth: 284,
    //                                             //
    //                                             //     //   autoplay: true,
    //                                             //     itemCount: snapshot.data?.banners.length,
    //                                             //
    //                                             //     viewportFraction: 1.0,
    //                                             //     itemHeight: 92,
    //                                             //     itemWidth: 284,
    //                                             //     // outer: true,
    //                                             //     itemBuilder: (BuildContext context,
    //                                             //     int index) {
    //                                             //     // _img = File('${snapshot.data
    //                                             //     //     ?.banners?[index].path}');
    //                                             //
    //                                             //     return Container(
    //                                             //     decoration: const BoxDecoration(
    //                                             //     borderRadius: BorderRadius
    //                                             //         .all(Radius.circular(20)),
    //                                             //     ),
    //                                             //     margin: const EdgeInsets.only(
    //                                             //     left: 10, right: 10),
    //                                             //     // child: Text('image'),
    //                                             //     child: Column (
    //                                             //     children: [
    //                                             //     Image.file(
    //                                             //     _img, fit: BoxFit.fill,
    //                                             //     width: 245,
    //                                             //     height: 165,
    //                                             //     // Image.asset(
    //                                             //     //   banners[index].image,
    //                                             //     //   // centerSlice: Rect.fromPoints(const Offset(50.0, 0.0), const Offset(0, 0)),
    //                                             //     //   fit: BoxFit.contain,
    //                                             //     //   alignment: Alignment.centerLeft,
    //                                             //     ),
    //                                             //     Column (
    //                                             //     children: [
    //                                             //     IconButton(
    //                                             //     onPressed: () {
    //                                             //     confirmDialog(context);
    //                                             //     setState(() {
    //                                             //     // устанавливаем индекс выделенного элемента
    //                                             //     selectedIndex = index;
    //                                             //     });
    //                                             //     print(snapshot.data?.banners?[selectedIndex].bannerId);
    //                                             //     var currentNewsId = snapshot.data?.banners?[selectedIndex].bannerId;
    //                                             //
    //                                             //     deleteNews(currentNewsId);
    //                                             //     Route route = MaterialPageRoute(
    //                                             //     builder: (
    //                                             //     context) => HomeAdmin());
    //                                             //     Navigator.push(context,route);
    //                                             //     },
    //                                             //     icon: SvgPicture.asset(
    //                                             //     'assets/images/delete.svg',
    //                                             //     semanticsLabel: 'Icon delete',
    //                                             //     height: 20.0,
    //                                             //     ),
    //                                             //     ),
    //                                             //     IconButton(
    //                                             //     onPressed: () {
    //                                             //     Route route = MaterialPageRoute(
    //                                             //     builder: (context) =>
    //                                             //     AddBanners());
    //                                             //     Navigator.push(context,route);
    //                                             //     },
    //                                             //     icon: SvgPicture.asset(
    //                                             //     'assets/images/add.svg',
    //                                             //     semanticsLabel: 'Icon add',
    //                                             //     height: 20.0,
    //                                             //     ),
    //                                             //     )
    //                                             //     ]
    //                                             //     ),
    //                                             //     ]
    //                                             //     )
    //                                             //     );
    //                                             //     },
    //                                             //     // control: SwiperControl(),
    //                                             //     ),
    //                                             //
    //                                             //
    //                                             //         ]
    //                                             // );
    //                                             //         }
    //                                             //       }
    //                                             //     ),
    //                                             //   ),
    //                                             // ]
    //                                             // ),
    //
    //
    //                                             const TitlePage(
    //                                                 title: 'мы в соцсетях'),
    //
    //                                             Socials(),
    //
    //
    //                                           ]
    //                                       )
    //                                   )
    //                               );
    //                             }
    //                             }
    //             )
    //             )
    //           ]
    //       ),
    //
    //     ),
    //
    //     //body: Home(),
    //   )
    //     ]
    // ),
    //     ),

        drawer: NavDrawerAdmin(),



      ),



    );
  }
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Удалить banner?'.toUpperCase(),
          textAlign: TextAlign.center,
          style: styleTextAlertDialog,
        ),
        actions: <Widget>[
          Container (
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        'Да'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        // var userId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeAdmin()));
                      },
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        'Нет'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]
              )
          )


        ],
      );
    },
  );
}

Future<BannersList> getBannersList() async {
  print('getBannersList');
  const url = baseUrl + '/test/banners_list.php';
  final response = await http.get(Uri.parse(url));
  print('response getBannerLists');
  print(response.body);
  if(response.statusCode == 200) {
    return BannersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

deleteBanner(bannerId) async {
  print('delete banner admin');
  String apiurl = baseUrl + "/test/delete_banner.php";

  var response = await http.post(Uri.parse(apiurl), body: {
    'bannerId': bannerId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    print('banner deleted');
    print(response.statusCode);
    print(response.body);
    return response.body;
    //return New.fromJson(json.decode(response.body));

    // setState(() {
    //   showprogress = false; //don't show progress indicator
    //   error = true;
    //   errormsg = jsondata["message"];
    // });

  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

