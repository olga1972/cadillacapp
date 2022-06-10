// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:getwidget/getwidget.dart';
import 'package:cadillac/widgets/carousel.dart';
// import 'package:flutter_swiper/flutter_swiper.dart'
import 'package:card_swiper/card_swiper.dart';
// void main() => runApp(Gallery());


import '../../models/users.dart';


class Gallery extends StatelessWidget {
Gallery({Key? key, }) : super(key: key);
  List<String> images = [
    "assets/images/cadillac-eldorado.png",
    "assets/images/cadillac-escalada.png",
    "assets/images/cadillac-orange.png",
  ];

  //final String userUuId;
  // late final dynamic currentUser;


@override
Widget build(BuildContext context) {
    dynamic currentUser;
    //dynamic cars;


    //print('id5: $userUuId');
    // print('currentUser: $currentUser');
    // var auto = currentUser.cars;
    // print('cars: $auto');
    // images.add(auto[0]);
    // images.add(auto[1]);
    // images.add(auto[2]);
    // print('cars: $images[0]');
    // return GFItemsCarousel (
    //   rowCount: 3,
    //   children: images.map(
    //         (url) {
    //       return Container(
    //         margin: EdgeInsets.all(5.0),
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //           child:
    //           Image.network(url, fit: BoxFit.cover, width: 1000.0),
    //         ),
    //       );
    //     },
    //   ).toList(),
   // );

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        // body: SliderPlugin(images),
        body: Swiper(
              //containerHeight: 160,
              //containerWidth: 390,
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
                CustomLayoutOption(startIndex: -1, stateCount: 2)
                    ..addTranslate([
                  const Offset(-10.0, 0.0),
                  const Offset(294.0, 0.0),
                  // const Offset(304.0, 0.0)
                ]),

              viewportFraction: 0.8,
              itemHeight: 160,
              itemWidth: 284,
              // outer: true,
              itemBuilder: (BuildContext context, int index) {

                return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Image.asset(
                    images[index],
                    // centerSlice: Rect.fromPoints(const Offset(50.0, 0.0), const Offset(0, 0)),
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                );
              },

              // indicatorLayout: PageIndicatorLayout.COLOR,
              // autoplay: true,
              itemCount: images.length,
              // itemWidth: 285.0,
              pagination: const SwiperPagination(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0),
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Color(0xFF8F97BF),
                      size: 7.0,
                      activeSize: 7.0
                  )
              )
          ),
        )
          // control: SwiperControl(),

    );

  }


}

// SliderPlugin(images) {
//   int activePage = 0;
//
//   return Container (
//     child: (
//       Stack (
//
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(
//               // height: 250.0,
//               disableCenter: true,
//               enlargeCenterPage: true,
//               onPageChanged: (position, reason) {
//                 print(reason);
//                 print(CarouselPageChangedReason.controller);
//               },
//               enableInfiniteScroll: false,
//             ),
//             items: images.map<Widget>((i) {
//               return Builder(builder: (BuildContext context) {
//                 return Column(children: [
//                   Container(
//                     // margin: EdgeInsets.zero,
//                     // padding: EdgeInsets.zero,
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 0),
//                     child: Image(
//                       image: NetworkImage(i),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   // Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   // children: indicators(images.length, activePage)
//                   // )
//                 ]);
//               });
//             }).toList(),
//           ),
//           Container (
//             margin: EdgeInsets.only(top: 112.0),
//             child: Row (
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: indicators(images.length, activePage)
//             ),
//           )
//
//
//
//         ]
//       )
//     )
//
//   );
// }

// decoration: BoxDecoration(
//   color: Colors.transparent,
//   borderRadius: BorderRadius.circular(15),
//   shape: BoxShape.rectangle,
//   image: DecorationImage(image: NetworkImage(i))
// ),

// class Carousel extends StatefulWidget {
//   const Carousel({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<Carousel> createState() => CarouselState();
//
//
// }
//
// class CarouselState extends State<Carousel> {
//   late PageController pageController;
//
//   List<String> images = [
//     "assets/images/cadillac-escalada.png",
//     "assets/images/cadillac-eldorado.png",
//     "assets/images/cadillac-orange.png",
//   ];
//
//   int activePage = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController(viewportFraction: 0.8, initialPage: 1);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: 200,
//           child: PageView.builder(
//               itemCount: images.length,
//               pageSnapping: true,
//               controller: pageController,
//               onPageChanged: (page) {
//                 setState(() {
//                   activePage = page;
//                 });
//               },
//               itemBuilder: (context, pagePosition) {
//                 bool active = pagePosition == activePage;
//
//                 return slider(images,pagePosition,active);
//               }),
//         ),
//         Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: indicators(images.length,activePage))
//       ],
//     );
//   }
// }
//
// AnimatedContainer slider(images, pagePosition, active) {
//   double margin = active ? 10 : 20;
//
//   return AnimatedContainer(
//     duration: Duration(milliseconds: 500),
//     curve: Curves.easeInOutCubic,
//     margin: EdgeInsets.all(margin),
//     decoration: BoxDecoration(
//         image: DecorationImage(image: NetworkImage(images[pagePosition]))),
//   );
// }
//
// imageAnimation(PageController animation, images, pagePosition) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (context, widget) {
//       print(pagePosition);
//
//       return SizedBox(
//         width: 200,
//         height: 160,
//         child: widget,
//       );
//     },
//     child: Container(
//       margin: EdgeInsets.all(10),
//       child: Image.network(images[pagePosition]),
//     ),
//   );
// }
//
List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(1),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
          color: currentIndex == index ? Color(0xFF2C335E) : Color(0xFF181C33),
          shape: BoxShape.circle),
    );
  });
}
