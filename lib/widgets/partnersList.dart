// // import 'dart:html';
//
// import 'package:cadillac/widgets/titlePage.dart';
// import 'package:flutter/material.dart';
// // import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:getwidget/getwidget.dart';
// // import 'package:getwidget/getwidget.dart';
// import 'package:cadillac/widgets/carousel.dart';
// // import 'package:cadillac/models/adsBanner.dart';
// // import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:card_swiper/card_swiper.dart';
//
//
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:io';
//
// import '../models/partners.dart';
// import '../variables.dart';
// // void main() => runApp(Gallery());
//
// class PartnersList extends StatefulWidget {
//   PartnersList({Key? key}) : super(key: key);
//
//   get partners => null;
//
//   @override
//   State<PartnersList> createState() => _PartnersListState();
// }
//
// class _PartnersListState extends State<PartnersList> {
//
//   int selectedIndex = 1;
//
//   late Future<PartnersList> partnersList;
//
//   //late Future<Partner> partners;
//   late String partnerId;
//
//
//   late String path = "assets/images/avatar.png";
//   // late List<dynamic> partnerImage;
//   //late Future<New> deleteNews;
//
//   @override
//   void initState() {
//     super.initState();
//     partnersList = getPartnersList();
//
//   }
//
//   bool isLoadedImage = false;
//   late File _image;
//   late String currentPartnerId;
//
//   @override
//   Widget build(BuildContext context) {
//
//     // int id = partners[0].id;
//     // String name = partners[0].name;
//     // String image = partners[0].image;
//
//     return MaterialApp(
//         title: 'Material App',
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: Colors.transparent,
//           // body: SliderPlugin(images),
//           body: Container (
//               width: 310,
//               //height: 830,
//               //margin: const EdgeInsets.only(bottom: 40),
//               child: FutureBuilder<PartnersList>(
//                   future: partnersList,
//                   builder: (context, snapshot) {
//
//                     var partners = snapshot.data?.partners;
//                     List<Partner>? partnersList = snapshot.data?.partners;
//                     print('partners');
//                     print(partnersList);
//
//                     if (snapshot.connectionState !=
//                         ConnectionState.done) {
//                       return const Center(
//                           child: CircularProgressIndicator());
//                     }
//
//                     if (snapshot.hasError) {
//                       return Center(
//                           child: Text(snapshot.error.toString()));
//                     }
//
//                     if (snapshot.hasData) {
//                       return Swiper(
//                         // containerHeight: 92,
//                         containerWidth: 284,
//                         // layout: SwiperLayout.CUSTOM,
//                         // customLayoutOption:
//                         //   CustomLayoutOption(startIndex: -1, stateCount: 3)
//                         //       .addTranslate([
//                         //     const Offset(-304.0, 0.0),
//                         //     const Offset(0.0, 0.0),
//                         //     const Offset(304.0, 0.0)
//                         //   ]),
//                         autoplay: true,
//                         // itemCount: partners.length,
//                         itemCount: snapshot.data
//                             ?.partners?.length,
//                         viewportFraction: 1.0,
//                         itemHeight: 92,
//                         itemWidth: 284,
//                         // outer: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           var fileExtension = snapshot
//                               .data?.partners[index]
//                               .path.substring(
//                               (snapshot.data
//                                   ?.partners[index]
//                                   .path.length)! - 3);
//                           if (fileExtension ==
//                               'jpg' ||
//                               fileExtension ==
//                                   'png' ||
//                               fileExtension ==
//                                   'svg') {
//                             isLoadedImage = true;
//                           } else {
//                             isLoadedImage = false;
//                           }
//                           _image = File(
//                               '${snapshot.data
//                                   ?.partners?[index]
//                                   ?.path}');
//                           return Container (
//                               width: 284,
//                               height: 160,
//                               decoration: BoxDecoration(
//                                 color: Color(0XffE4E6FF),
//                                 borderRadius: BorderRadius.all(Radius
//                                     .circular(20.0)),
//                               ),
//                               margin: const EdgeInsets.only(bottom: 10.0, top: 10),
//                               child: (isLoadedImage &&_image.existsSync()) ? Image.file(_image, fit: BoxFit.cover, width: 284, height: 160) :
//                               Text('no image',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.normal,
//                                     fontFamily: 'CadillacSans',
//                                     color: Color(0xFF8F97BF),
//                                     height: 1.7, //line-height / font-size
//                                   ))
//                           );
//                         },
//                         // control: SwiperControl(),
//                       );
//                     }
//
//                     return const Center(child: Text('no data'));
//                   }
//               )
//           )
//
//         )
//
//     );
//
//   }
//
// }
//
// Future<PartnersList> getPartnersList() async {
//   print('getPartnersList');
//   const url = baseUrl + '/test/partners_list.php';
//   final response = await http.get(Uri.parse(url));
//   print('response getPartnersList');
//   print(response.body);
//   if(response.statusCode == 200) {
//     return PartnersList.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }
//
