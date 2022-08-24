import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cadillac/pages/addBanners.dart';

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:cadillac/widgets/socials.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../NavDrawerAdmin.dart';
import '../models/banners.dart';
import '../variables.dart';
import 'editAds.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int selectedIndex = 1;

  late Future<BannersList> bannersList;
  late String bannerId;
  bool isLoadedImage = false;
  late String currentBannerId;

  @override
  void initState() {
    super.initState();
    bannersList = getBannersList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset('assets/images/burger.svg', semanticsLabel: 'Icon burger', height: 12.0),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              Container(
                width: 160,
                margin: const EdgeInsets.only(top: 22, right: 18.0),
                child: const Text(
                  'Редактировать рекламу',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'CadillacSans',
                    color: Colors.white,
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
                  Route route = MaterialPageRoute(builder: (context) => const EditAds());
                  Navigator.push(context, route);
                },
              ),
            ]),
        body: SafeArea(
          child: Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              Container(
                width: 284,
                margin: const EdgeInsets.only(top: 50),
                child: const TitlePageAdmin(title: 'главная'),
              ),
              Container(
                  width: 284,
                  margin: const EdgeInsets.only(top: 70, bottom: 70),
                  child: (Text(
                    'Став владельцем Cadillac, \nвы не просто приобретаете \nавтомобиль класса-люкс, \nвы вступаете в элитное сообщество, единомышленников'
                        .toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'CadillacSans',
                      color: Color(0xFF8F97BF),
                      height: 1.7, //line-height : font-size
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ))),
              SizedBox(
                  width: 320,
                  height: 140,
                  child: FutureBuilder<BannersList>(
                      future: bannersList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }

                        if (snapshot.hasData) {
                          int countImages = snapshot.data!.banners.length;
                          return Swiper(
                            containerWidth: 340,
                            viewportFraction: 1,
                            itemHeight: 107,
                            itemWidth: 340,
                            autoplay: true,
                            itemCount: countImages,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data?.banners[index].path != null) {
                                isLoadedImage = true;
                              } else {
                                isLoadedImage = false;
                              }
                              return Container(
                                  width: 320,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Stack(alignment: Alignment.centerRight, clipBehavior: Clip.none, children: [
                                      Container(
                                          width: 284,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Color(0XffE4E6FF),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10.0, top: 10, left: 10, right: 40),
                                          child: isLoadedImage
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.memory(base64.decode(snapshot.data?.banners[index].path ?? ''),
                                                      fit: BoxFit.cover, width: 245, height: 107))
                                              : const Text('no image',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Color(0xFF8F97BF),
                                                    height: 1.7, //line-height / font-size
                                                  ))),
                                      Column(children: [
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 30.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              confirmDialog(context);
                                              setState(() {
                                                // устанавливаем индекс выделенного элемента
                                                selectedIndex = index;
                                              });
                                              debugPrint(snapshot.data?.banners[selectedIndex].bannerId);
                                              var currentBannerId = snapshot.data?.banners[selectedIndex].bannerId;
                                              deleteBanner(currentBannerId);

                                              Route route = MaterialPageRoute(builder: (context) => const HomeAdmin());
                                              Navigator.push(context, route);
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
                                            Route route = MaterialPageRoute(builder: (context) => const AddBanners());
                                            Navigator.push(context, route);
                                          },
                                          child: SvgPicture.asset(
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
                                      ])
                                    ]),
                                  ]));
                            },
                            // control: SwiperControl(),
                          );
                        }
                        return const Center(child: Text('no data'));
                      })),
              const SizedBox(
                height: 20
              ),
              const TitlePageAdmin(title: 'мы в соцсетях'),
              const Socials()
            ])))
          ])),
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
        content: Text(
          'Удалить banner?'.toUpperCase(),
          textAlign: TextAlign.center,
          style: styleTextAlertDialog,
        ),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                MaterialButton(
                  padding: const EdgeInsets.all(14),
                  color: const Color(0xFFE4E6FF),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Да'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: styleTextAlertDialog,
                  ),
                  onPressed: () {
                    // var userId;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
                  },
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(14),
                  color: const Color(0xFFE4E6FF),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Нет'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: styleTextAlertDialog,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]))
        ],
      );
    },
  );
}

Future<BannersList> getBannersList() async {
  const url = baseUrl + '/test/banners_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint('response getBannerLists');
  debugPrint(response.body.toString());
  if (response.statusCode == 200) {
    return BannersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

deleteBanner(bannerId) async {
  debugPrint('delete banner admin');
  String apiUrl = baseUrl + "/test/delete_banner.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
    'bannerId': bannerId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    debugPrint('banner deleted');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    return response.body;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
