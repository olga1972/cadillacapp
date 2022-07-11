import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/src/material/input_border.dart';
//import 'package:cadillac/NavBar.dart';

//import 'package:cadillac/CustomAppBar.dart';

import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/addBanners.dart';

import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/bannersList.dart';



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../models/banners.dart';
import '../variables.dart';

import 'editAds.dart';
import 'gift.dart';
import 'newsAdmin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int selectedIndex = 1;

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
        '/home': (context) => const HomeAdmin(),
        // '/account': (context) => Account(currentUser: currentUser,),
        '/members': (context) => const Members(),
        '/newsAdmin': (context) => const NewsAdmin(),
        // '/shop': (context) => Shop(),
        '/partners': (context) => const Partners(),
        '/contacts': (context) => const Contacts(),
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
                    // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                                Route route = MaterialPageRoute(
                                    builder: (context) => const EditAds());
                                Navigator.push(context,route);
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
                          margin: const EdgeInsets.only(top: 80, bottom: 100),
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
                        SizedBox (
                          width: 320,
                          height: 140,
                            child: FutureBuilder<BannersList>(
                                future: bannersList,
                                builder: (context, snapshot) {

                                  var banners = snapshot.data?.banners;
                                  List<AdsBanner>? bannersList = snapshot.data?.banners;
                                  print('Banners');
                                  print(banners?.length);
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
                                      // containerHeight: 92,
                                      containerWidth: 340,
                                      // layout: SwiperLayout.CUSTOM,
                                      // customLayoutOption:
                                      // CustomLayoutOption(startIndex: -1, stateCount: 2)
                                      //   ..addTranslate([
                                      //     const Offset(-28.0, 0.0),
                                      //     const Offset(256.0, 0.0),
                                      //     // const Offset(304.0, 0.0)
                                      //   ]),

                                      viewportFraction: 1,
                                      itemHeight: 107,
                                      itemWidth: 340,
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

                                          Container (
                                            width: 284,
                                            height: 107,
                                            decoration: const BoxDecoration(
                                              color: Color(0XffE4E6FF),
                                              borderRadius: BorderRadius.all(Radius
                                                  .circular(10.0)),
                                            ),
                                            margin: const EdgeInsets.only(bottom: 10.0, top: 10, left: 10,right: 40),
                                              child: isLoadedImage ? Image.memory(
                                                base64.decode(snapshot.data?.banners[index].path ?? ''),
                                                fit: BoxFit.cover, height: 107)
                                                  : Text('no image',
                                                  textAlign: TextAlign
                                                      .center,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Color(
                                                        0xFF8F97BF),
                                                    height: 1.7, //line-height / font-size
                                                  ))
                                          ),
                                          Column (
                                            children: [
                                            Container (
                                              margin: const EdgeInsets.only(bottom: 30.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                confirmDialog(context);
                                                setState(() {
                                                // устанавливаем индекс выделенного элемента
                                                selectedIndex = index;
                                                });
                                                print(snapshot.data?.banners[selectedIndex].bannerId);
                                                var currentBannerId = snapshot.data?.banners[selectedIndex].bannerId;
                                                deleteBanner(currentBannerId);

                                                Route route = MaterialPageRoute(
                                                builder: (context) =>
                                                const HomeAdmin());
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
                                              const AddBanners());
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
                                              initialValue: '${snapshot.data?.banners[selectedIndex].bannerId}',
                                              onSaved: (value) => currentBannerId = value!,
                                              ),
                                            ),
                                            ]
                                            )
                                        ]
                                    )
                                        ]
                                        )
                                        );
                                      },
                                      // control: SwiperControl(),
                                    );
                                  }

                                  return const Center(child: Text('no data'));
                                }
                            )

                          )
                                  ]
                                )
                            )


                )
              ]
            )
        ),


        drawer: const NavDrawerAdmin(),



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
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
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
                                builder: (context) => const HomeAdmin()));
                      },
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
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

