import 'package:flutter/material.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cadillac/widgets/socials.dart';

import 'package:cadillac/models/products.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late Future<ProductsList> productsList;

  get currentUser => null;
  List<String> images = [
    "assets/images/notebook.png",
    "assets/images/notebook.png",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Shop()));
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
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(
                      width: 284,
                      margin: const EdgeInsets.only(top: 30, bottom: 70),
                      child: const TitlePage(title: 'клубная атрибутика'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 279,
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                      transformAlignment: Alignment.centerLeft,
                      child: Swiper(
                        itemCount: 2,
                        allowImplicitScrolling: true,
                        layout: SwiperLayout.CUSTOM,
                        customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 2)
                          ..addTranslate([
                            const Offset(0.0, 0.0),
                            const Offset(270.0, 0.0),
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Text(
                            "Блокнот".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFF8F97BF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 284,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: const [
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
                        ),
                      ])
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            child: const TitlePage(title: 'Напишите нам'),
                          ),
                          const Socials()
                        ])
                      ],
                    )
              ])))
            ])))));
  }
}
