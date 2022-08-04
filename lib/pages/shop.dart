import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

import 'cardProduct.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late Future<ProductsList> productsList;

  List<String> images = [
    "assets/images/t-shirt.png",
    "assets/images/hoodie.png",
    "assets/images/notebook.png",
    "assets/images/stickers.png",
  ];

  @override
  void initState() {
    super.initState();
    productsList = readJson();
  }

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 130;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30, bottom: 20),
                    child: const TitlePage(title: 'клубная атрибутика'),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(
                            //margin: const EdgeInsets.only(bottom: 30),
                            alignment: Alignment.center,
                            width: 130,
                            height: 180,
                            child: Text(
                              "Футболки".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                              width: width,
                              height: 180,
                              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                              child: Swiper(
                                itemCount: 3,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                  ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                viewportFraction: 0.43,
                                itemHeight: 180,
                                itemWidth: 98,
                                autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        debugPrint('on long press');
                                        setState(() {
                                          // устанавливаем индекс выделенного элемента
                                          selectedIndex = index;
                                        });
                                        debugPrint('футболки');
                                        debugPrint(selectedIndex.toString());
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardProduct(index: selectedIndex)));
                                      },
                                      child: Container(
                                          width: 98,
                                          height: 180,
                                          padding: const EdgeInsets.only(bottom: 5),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE4E4FF),
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                                            SizedBox(
                                              width: 98,
                                              height: 132,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                child: Image.asset(
                                                  images[0],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: 98,
                                                height: 30,
                                                padding: const EdgeInsets.only(left: 7),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffE4E6FF),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  Text(
                                                    "Футболки ".toUpperCase(),
                                                    style:
                                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 10,
                                                    ),
                                                    color: const Color(0xFF12141F),
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      debugPrint('add');
                                                    },
                                                  ),
                                                ])
                                                //)
                                                ),
                                            Container(
                                                width: 88,
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                                  Text(
                                                    "2500 ",
                                                    style: TextStyle(fontSize: 7, color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    color: Color(0xFF12141F),
                                                    size: 8,
                                                  ),
                                                ])),
                                          ])));
                                },
                              ))
                        ]),
                        Row(children: [
                          Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 180,
                            child: Text(
                              "Худи".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                              width: width,
                              height: 180,
                              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                              child: Swiper(
                                itemCount: 3,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                  ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                viewportFraction: 0.43,
                                itemHeight: 180,
                                itemWidth: 98,
                                autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        debugPrint('on long press');
                                        setState(() {
                                          // устанавливаем индекс выделенного элемента
                                          selectedIndex = index;
                                        });
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardProduct(index: index)));
                                      },
                                      child: Container(
                                          width: 98,
                                          height: 180,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE4E4FF),
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              width: 98,
                                              height: 132,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                child: Image.asset(
                                                  images[1],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: 98,
                                                height: 30,
                                                padding: const EdgeInsets.only(left: 7),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffE4E6FF),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  Text(
                                                    "Худи ".toUpperCase(),
                                                    style:
                                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 10,
                                                    ),
                                                    color: const Color(0xFF12141F),
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      debugPrint('add');
                                                    },
                                                  ),
                                                ])),
                                            Container(
                                                width: 88,
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                                  Text(
                                                    "2500 ",
                                                    style: TextStyle(fontSize: 7, color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    color: Color(0xFF12141F),
                                                    size: 8,
                                                  ),
                                                ])),
                                          ])));
                                },
                              ))
                        ]),
                        Row(children: [
                          Container(
                            // margin: const EdgeInsets.only(bottom: 30),
                            alignment: Alignment.center,
                            width: 130,
                            height: 180,
                            child: Text(
                              "Худи".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                              width: width,
                              height: 180,
                              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                              child: Swiper(
                                itemCount: 3,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                  ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                viewportFraction: 0.43,
                                itemHeight: 180,
                                itemWidth: 98,
                                autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        debugPrint('on long press');
                                        setState(() {
                                          // устанавливаем индекс выделенного элемента
                                          selectedIndex = index;
                                        });
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardProduct(index: selectedIndex)));
                                      },
                                      child: Container(
                                          width: 98,
                                          height: 180,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE4E4FF),
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              width: 98,
                                              height: 132,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                child: Image.asset(
                                                  images[2],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: 98,
                                                height: 30,
                                                padding: const EdgeInsets.only(left: 7),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffE4E6FF),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  Text(
                                                    "Блокноты ".toUpperCase(),
                                                    style:
                                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 10,
                                                    ),
                                                    color: const Color(0xFF12141F),
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      debugPrint('add');
                                                    },
                                                  ),
                                                ])),
                                            Container(
                                                width: 88,
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                                  Text(
                                                    "2500 ",
                                                    style: TextStyle(
                                                        fontSize: 7,
                                                        //color: Colors.white,
                                                        color: Color(0xFF12141F)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    color: Color(0xFF12141F),
                                                    size: 8,
                                                  ),
                                                ])),
                                          ])));
                                },
                              ))
                        ]),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 130,
                              height: 180,
                              child: Text(
                                "Наклейки".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                                width: width,
                                height: 180,
                                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                                child: Swiper(
                                    itemCount: 3,
                                    layout: SwiperLayout.CUSTOM,
                                    customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                      ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                    viewportFraction: 0.43,
                                    itemHeight: 180,
                                    itemWidth: 98,
                                    autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                    outer: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            debugPrint('on long press');
                                            setState(() {
                                              // устанавливаем индекс выделенного элемента
                                              selectedIndex = index;
                                            });
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardProduct(index: index)));
                                          },
                                          child: Container(
                                              width: 98,
                                              height: 180,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFE4E4FF),
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(children: [
                                                Container(
                                                  width: 98,
                                                  height: 132,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    child: Image.asset(
                                                      images[3],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    width: 98,
                                                    height: 30,
                                                    padding: const EdgeInsets.only(left: 10),
                                                    //padding: EdgeInsets.zero,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xffE4E6FF),
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(10.0),
                                                        bottomRight: Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                      Text(
                                                        "Наклейки ".toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(0xFF12141F)),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 10,
                                                        ),
                                                        color: const Color(0xFF12141F),
                                                        padding: EdgeInsets.zero,
                                                        onPressed: () {
                                                          debugPrint('add');
                                                        },
                                                      ),
                                                    ])),
                                                Container(
                                                    width: 88,
                                                    padding: const EdgeInsets.only(left: 3),
                                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                                      Text(
                                                        "2500 ",
                                                        style: TextStyle(fontSize: 7, color: Color(0xFF12141F)),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Icon(
                                                        Icons.currency_ruble,
                                                        color: Color(0xFF12141F),
                                                        size: 8,
                                                      ),
                                                    ])),
                                              ])));
                                    })),
                          ],
                        ),
                      ]))
                ])),
              ),
            ]),
          ),
          drawer: const NavDrawer(),
        ));
  }
}
