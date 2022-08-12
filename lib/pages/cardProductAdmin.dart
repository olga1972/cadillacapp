import 'package:cadillac/pages/shopAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cadillac/pages/account.dart';

import 'package:cadillac/widgets/socials.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cadillac/variables.dart';

class CardProductAdmin extends StatefulWidget {
  const CardProductAdmin({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CardProductAdmin> createState() => _CardProductAdminState();
}

class _CardProductAdminState extends State<CardProductAdmin> {
  late Future<ProductsList> productsList;

  List<String> images = [
    "assets/images/t-shirt.png",
    "assets/images/hoodie.png",
    "assets/images/notebook.png",
  ];

  @override
  void initState() {
    super.initState();
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
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopAdmin()));
                    },
                  );
                },
              ),
            ),
            body: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 870,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Container(
                          width: 320,
                          margin: const EdgeInsets.only(bottom: 50),
                          child: const TitlePageAdmin(title: 'клубная атрибутика'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 330,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                          child: Swiper(
                              itemCount: 2,
                              allowImplicitScrolling: true,
                              layout: SwiperLayout.CUSTOM,
                              customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 2)
                                ..addTranslate([
                                  const Offset(-50.0, 0.0),
                                  const Offset(160.0, 0.0),
                                ]),
                              viewportFraction: 0.8,
                              itemHeight: 279,
                              itemWidth: 260,
                              outer: true,
                              pagination: const SwiperPagination(
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                  builder: DotSwiperPaginationBuilder(color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0)),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 279,
                                    margin: const EdgeInsets.only(left: 0, right: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      child: Image.asset(
                                        images[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ));
                              }),
                        ),
                        SizedBox(
                          width: 320,
                          height: 45,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(
                              "Блокнот".toUpperCase(),
                              style: const TextStyle(fontSize: 24, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              iconSize: 20.0,
                              icon: SvgPicture.asset(
                                'assets/images/delete.svg',
                                semanticsLabel: 'Icon delete',
                                height: 20.0,
                              ),
                              onPressed: () {
                                confirmDialog(context);
                                //   Route route = MaterialPageRoute(
                                //       builder: (
                                //           context) => const Gift());
                                //   Navigator.push(context, route);
                              },
                            )
                          ]),
                        ),
                        SizedBox(
                            width: 320,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Row(children: const [
                                Text(
                                  "3700 ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.currency_ruble,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ]),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                iconSize: 20.0,
                                icon: SvgPicture.asset(
                                  'assets/images/add.svg',
                                  semanticsLabel: 'Icon add',
                                  height: 20.0,
                                ),
                                onPressed: () {
                                  //   Route route = MaterialPageRoute(
                                  //       builder: (
                                  //           context) => const Gift());
                                  //   Navigator.push(context, route);
                                },
                              )
                            ])),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Container(
                                margin: const EdgeInsets.only(top: 100, bottom: 15),
                                child: Text(
                                  "Хотите такой блокнот?".toUpperCase(),
                                  style: const TextStyle(fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: const TitlePageAdmin(title: 'Напишите нам'),
                            ),
                            const Socials()
                          ])
                        ])
                      ])))
                    ])))));
  }
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Удалить товар?'.toUpperCase(),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Account()));
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
