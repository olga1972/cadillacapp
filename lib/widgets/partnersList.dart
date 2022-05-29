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

class PartnersList extends StatelessWidget {
  PartnersList({Key? key}) : super(key: key);

  final List<AdsBanner> partners = [
    AdsBanner(
      id: 1,
      name: 'Golf Club',
      image: 'assets/images/golf_club.png',
    ),
    AdsBanner(
      id: 2,
      name: 'Ritz-Carlton',
      image: 'assets/images/image16.png',
    ),
    AdsBanner(
      id: 3,
      name: 'Ritz-Carlton',
      image: 'assets/images/image18.png',
    ),
    AdsBanner(
      id: 4,
      name: 'Ritz-Carlton',
      image: 'assets/images/image19.png',
    ),
    AdsBanner(
      id: 5,
      name: 'Ritz-Carlton',
      image: 'assets/images/image17.png',
    ),
  ];
  // List<String> images = [
  //   "assets/images/image11.png",
  //   "assets/images/image13.png",
  // ];

  @override
  Widget build(BuildContext context) {

    int id = partners[0].id;
    String name = partners[0].name;
    String image = partners[0].image;

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
            autoplay: true,
            itemCount: partners.length,
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
                  partners[index].image,
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



