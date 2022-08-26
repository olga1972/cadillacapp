import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cadillac/pages/accountAdmin.dart';

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';
import '../variables.dart';
import 'addProduct.dart';
import 'cardProductAdmin.dart';

class ShopAdmin extends StatefulWidget {
  const ShopAdmin({Key? key}) : super(key: key);

  @override
  State<ShopAdmin> createState() => _ShopAdminState();
}

class _ShopAdminState extends State<ShopAdmin> {
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
    productsList = getProductsList();
  }

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 130;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
            shadowColor: const Color(0xFF2C335E),
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
              child: ListView(
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  child: const TitlePageAdmin(title: 'клубная атрибутика'),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder<ProductsList>(
                    future: productsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      if (snapshot.hasData) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 130,
                                  height: 180,
                                  child: Center(
                                    child: Text(
                                      "Футболки".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
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
                                      autoplay: MediaQuery
                                          .of(context)
                                          .size
                                          .width > 920 ? true : false,
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
                                              Navigator.pushReplacement(
                                                  context, MaterialPageRoute(builder: (context) => CardProductAdmin(index: selectedIndex)));
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
                                                        images[0],
                                                        fit: BoxFit.fill,
                                                      ),),),
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
                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(
                                                              0xFF12141F)),
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

                              Column(children: [
                                Container(
                                    width: 380,
                                    margin: const EdgeInsets.only(left: 15),
                                    alignment: const Alignment(-1, 1),
                                    child: IconButton(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 20.0,
                                      icon: SvgPicture.asset(
                                        'assets/images/delete.svg',
                                        semanticsLabel: 'Icon delete',
                                        height: 20.0,
                                      ),
                                      onPressed: () {
                                        confirmDialog(context);
                                      },
                                    )),

                                Container(
                                    width: 310,
                                    height: 20,
                                    margin: const EdgeInsets.only(left: 15, bottom: 20),
                                    alignment: const Alignment(1, 1),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        Route route = MaterialPageRoute(builder: (context) => const AddProduct());
                                        Navigator.push(context, route);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/add.svg',
                                        semanticsLabel: 'Icon add',
                                        height: 20.0,
                                      ),
                                    )),
                                // Container(
                                //     width: 380,
                                //     margin: const EdgeInsets.only(left: 15),
                                //     alignment: const Alignment(-1, 1),
                                //     child: IconButton(
                                //       alignment: Alignment.centerLeft,
                                //       padding: const EdgeInsets.all(0),
                                //       iconSize: 20.0,
                                //       icon: SvgPicture.asset(
                                //         'assets/images/add.svg',
                                //         semanticsLabel: 'Icon add',
                                //         height: 20.0,
                                //       ),
                                //       onPressed: () {
                                //           Route route = MaterialPageRoute(
                                //               builder: (
                                //                   context) => const AddProduct());
                                //           Navigator
                                //               .push(
                                //               context,
                                //               route);
                                //       },
                                //     ))
                              ],
                              ),
                            ]);
                      }
                      return const Center(child: Text('no data'));
                    }
                    )
           )],
          )])),
          drawer: const NavDrawerAdmin(),
        ));
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountAdmin()));
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

Future<ProductsList> getProductsList() async {
  const url = baseUrl + '/test/products_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint('response members getProductLists');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return ProductsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
