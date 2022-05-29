// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:getwidget/getwidget.dart';
import 'package:cadillac/widgets/carousel.dart';
import 'package:cadillac/models/adsBanner.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:card_swiper/card_swiper.dart';
// void main() => runApp(Gallery());

class Banners extends StatelessWidget {
  Banners({Key? key}) : super(key: key);

  final List<AdsBanner> banners = [
    AdsBanner(
      id: 1,
      name: 'Cadillac',
      image: 'assets/images/image11.png',
    ),
    AdsBanner(
      id: 2,
      name: 'Оригинальные запчасти',
      image: 'assets/images/image13.png',
    ),
  ];
  // List<String> images = [
  //   "assets/images/image11.png",
  //   "assets/images/image13.png",
  // ];

  @override
  Widget build(BuildContext context) {

    int id = banners[0].id;
    String name = banners[0].name;
    String image = banners[0].image;

    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.transparent,
          // body: SliderPlugin(images),
          body: Swiper(
            // containerHeight: 92,
            containerWidth: 284,
            // layout: SwiperLayout.CUSTOM,
            // customLayoutOption:
            //   CustomLayoutOption(startIndex: -1, stateCount: 3)
            //       .addTranslate([
            //     const Offset(-304.0, 0.0),
            //     const Offset(0.0, 0.0),
            //     const Offset(304.0, 0.0)
            //   ]),
            //   autoplay: true,
              itemCount: banners.length,
              viewportFraction: 1.0,
              itemHeight: 92,
              itemWidth: 284,
              // outer: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Image.asset(
                    banners[index].image,
                    // centerSlice: Rect.fromPoints(const Offset(50.0, 0.0), const Offset(0, 0)),
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                );
              },
              // control: SwiperControl(),
          ),
        )

    );

  }
}



