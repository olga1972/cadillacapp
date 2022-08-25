import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/banners.dart';
import '../variables.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,

      // routes: {
      //   '/home': (context) => const Home(),
      //   '/members': (context) => const Members(),
      //   '/news': (context) => const News(),
      //   '/partners': (context) => const Partners(),
      //   '/contacts': (context) => const Contacts(),
      //   '/gift': (context) => const Gift(),
      // },

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF181c33),
          shadowColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset('assets/images/burger.svg', semanticsLabel: 'Icon burger', height: 12.0),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

                Container(
                  width: 284,
                  margin: const EdgeInsets.only(top: 30),
                  child: const TitlePage(title: 'главная'),
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
                Container(
                    width: 284,
                    height: 107,
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                    color: const Color(0xFF181C33),
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
                              containerWidth: 284,
                              viewportFraction: 1,
                              itemWidth: 284,
                              autoplay: true,
                              itemCount: countImages,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data?.banners[index].path != null) {
                                  isLoadedImage = true;
                                } else {
                                  isLoadedImage = false;
                                }
                                return Container(
                                    width: 284,
                                    height: 107,
                                    decoration: const BoxDecoration(
                                      color: Color(0XffE4E6FF),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 10.0, top: 10, left: 10, right: 10),
                                    child: isLoadedImage
                                        ? ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                            child: Image.memory(base64.decode(snapshot.data?.banners[index].path ?? ''),
                                                fit: BoxFit.cover, width: 284, height: 107))
                                        : const Text('no image',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'CadillacSans',
                                              color: Color(0xFF8F97BF),
                                              height: 1.7, //line-height / font-size
                                            )));
                              },
                              // control: SwiperControl(),
                            );
                          }
                          return const Center(child: Text('no data'));
                        })),
                const TitlePage(title: 'мы в соцсетях'),
                const Socials(),
              ]))),
            ]),
          ),
        ),
        drawer: const NavDrawer(),
      ),
    );
  }
}

Future<BannersList> getBannersList() async {
  const url = baseUrl + '/test/banners_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint('response getBannersList');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return BannersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
