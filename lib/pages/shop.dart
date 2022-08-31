import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../variables.dart';
import 'cardProduct.dart';
import 'data.dart';
import 'orderProduct.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late Future<ProductsList> productsList;
  late Future<CategoriesList> categoriesList;

  @override
  void initState() {
    super.initState();
    productsList = getProductsList();
    categoriesList = getCategoriesList();
  }

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 165;
    return ChangeNotifierProvider<Data>(
        create: (context) => Data(),
        builder: (context, child) {
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
                body: Consumer<Data>(builder: (context, data, child) {
                  return Center(
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const TitlePage(title: 'клубная атрибутика'),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width - 25,
                          child: FutureBuilder<CategoriesList>(
                              future: categoriesList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState != ConnectionState.done) {
                                  return const Center(child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(child: Text(snapshot.error.toString()));
                                }

                                if (snapshot.hasData) {
                                  return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.categories.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          var currentCategory = snapshot.data?.categories[index].category;
                                          return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: 130,
                                              height: 180,
                                              child: Center(
                                                child: Text(
                                                  "$currentCategory".toUpperCase(),
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
                                                        var productsList = snapshot.data?.products;
                                                        // print(productsList?.where((o) => o.category == currentCategory));
                                                        productsList = productsList?.where((o) => o.category == currentCategory).toList();
                                                        // print(productsList?.isEmpty);

                                                        dynamic itemCount;
                                                        // bool isEmpty = true;
                                                        if (productsList?.length != null && productsList != null) {
                                                          itemCount = productsList.length;
                                                          // isEmpty = false;
                                                        } else {
                                                          itemCount = null;
                                                          // isEmpty = true;
                                                        }
                                                        print(itemCount);
                                                        return itemCount > 0
                                                            ? Swiper(
                                                                itemCount: itemCount,
                                                                layout: SwiperLayout.CUSTOM,
                                                                customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                                                  ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                                                viewportFraction: 0.43,
                                                                itemHeight: 180,
                                                                // itemWidth: 98,
                                                                itemWidth: 100,
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
                                                                        String productId = productsList![index].productId;
                                                                        Provider.of<Data>(context, listen: false).updateProductId(productId);
                                                                        debugPrint('футболки');
                                                                        debugPrint(selectedIndex.toString());
                                                                        Navigator.pushReplacement(
                                                                            context, MaterialPageRoute(builder: (context) => CardProduct()));
                                                                      },
                                                                      child: Container(
                                                                          // width: 98,
                                                                          width: 100,
                                                                          height: 180,
                                                                          decoration: const BoxDecoration(
                                                                            color: Color(0xFFE4E4FF),
                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          child: Column(children: [
                                                                            Container(
                                                                              // width: 98,
                                                                              width: 100,
                                                                              height: 132,
                                                                              decoration: const BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                child: Image.memory(
                                                                                  base64.decode(productsList?[index].productImage ?? ''),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                                // width: 98,
                                                                                width: 100,
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
                                                                                    "${productsList?[index].productName} ".toUpperCase(),
                                                                                    style: const TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 7,
                                                                                        letterSpacing: 0,
                                                                                        color: Color(0xFF12141F)),
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
                                                                                      Route route =
                                                                                          MaterialPageRoute(builder: (context) => const OrderProduct());
                                                                                      Navigator.push(context, route);
                                                                                    },
                                                                                  ),
                                                                                ])),
                                                                            Container(
                                                                                width: 88,
                                                                                padding: const EdgeInsets.only(left: 3),
                                                                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                  Text(
                                                                                    "${productsList?[index].productPrice} ",
                                                                                    style: const TextStyle(fontSize: 7, color: Color(0xFF12141F)),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                  const Icon(
                                                                                    Icons.currency_ruble,
                                                                                    color: Color(0xFF12141F),
                                                                                    size: 8,
                                                                                  ),
                                                                                ])),
                                                                          ])));
                                                                },
                                                              )
                                                            : Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                                                Flexible(
                                                                    child: Text(
                                                                  'В этой категории товаров нет',
                                                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                                                  textAlign: TextAlign.center,
                                                                ))
                                                              ]);
                                                      }
                                                      return const Center(child: CircularProgressIndicator());
                                                    }))
                                          ]);
                                        }),
                                    // Row(children: [
                                    //   Container(
                                    //     //margin: const EdgeInsets.only(bottom: 30),
                                    //     alignment: Alignment.center,
                                    //     width: 130,
                                    //     height: 180,
                                    //     child: Text(
                                    //       "snapshot.data?.products[index].category".toUpperCase(),
                                    //       style: const TextStyle(
                                    //         fontSize: 14,
                                    //         color: Colors.white,
                                    //       ),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    //   Container(
                                    //       width: width,
                                    //       height: 180,
                                    //       margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                                    //       child: Swiper(
                                    //         itemCount: 3,
                                    //         layout: SwiperLayout.CUSTOM,
                                    //         customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 3)
                                    //           ..addTranslate([const Offset(-71.0, 0.0), const Offset(40.0, 0.0), const Offset(151.0, 0.0)]),
                                    //         viewportFraction: 0.43,
                                    //         itemHeight: 180,
                                    //         itemWidth: 98,
                                    //         autoplay: MediaQuery
                                    //             .of(context)
                                    //             .size
                                    //             .width > 920 ? true : false,
                                    //         outer: true,
                                    //         itemBuilder: (BuildContext context, int index) {
                                    //           return GestureDetector(
                                    //               onTap: () {
                                    //                 debugPrint('on long press');
                                    //                 setState(() {
                                    //                   // устанавливаем индекс выделенного элемента
                                    //                   selectedIndex = index;
                                    //                 });
                                    //
                                    //                 debugPrint(selectedIndex.toString());
                                    //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardProduct(index: selectedIndex)));
                                    //               },
                                    //               child: Container(
                                    //                   width: 98,
                                    //                   height: 180,
                                    //                   padding: const EdgeInsets.only(bottom: 5),
                                    //                   decoration: const BoxDecoration(
                                    //                     color: Color(0xFFE4E4FF),
                                    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //                   ),
                                    //                   child: Column(mainAxisSize: MainAxisSize.min, children: [
                                    //                     SizedBox(
                                    //                       width: 98,
                                    //                       height: 132,
                                    //                       child: ClipRRect(
                                    //                         borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    //                         child: Image.asset(
                                    //                           images[0],
                                    //                           fit: BoxFit.fill,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                     Container(
                                    //                         width: 98,
                                    //                         height: 30,
                                    //                         padding: const EdgeInsets.only(left: 7),
                                    //                         decoration: const BoxDecoration(
                                    //                           color: Color(0xffE4E6FF),
                                    //                           borderRadius: BorderRadius.only(
                                    //                             bottomLeft: Radius.circular(10.0),
                                    //                             bottomRight: Radius.circular(10.0),
                                    //                           ),
                                    //                         ),
                                    //                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //                           Text(
                                    //                             "snapshot.data?.products[index].productName".toUpperCase(),
                                    //                             style:
                                    //                             const TextStyle(fontWeight: FontWeight.bold, fontSize: 7, letterSpacing: 0, color: Color(0xFF12141F)),
                                    //                             textAlign: TextAlign.center,
                                    //                           ),
                                    //                           IconButton(
                                    //                             icon: const Icon(
                                    //                               Icons.add,
                                    //                               size: 10,
                                    //                             ),
                                    //                             color: const Color(0xFF12141F),
                                    //                             padding: EdgeInsets.zero,
                                    //                             onPressed: () {
                                    //                               debugPrint('add');
                                    //                             },
                                    //                           ),
                                    //                         ])
                                    //                       //)
                                    //                     ),
                                    //                     Container(
                                    //                         width: 88,
                                    //                         padding: const EdgeInsets.only(left: 3),
                                    //                         child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                    //                           Text(
                                    //                             "snapshot.data?.products[index].productPrice ",
                                    //                             style: TextStyle(fontSize: 7, color: Color(0xFF12141F)),
                                    //                             textAlign: TextAlign.center,
                                    //                           ),
                                    //                           Icon(
                                    //                             Icons.currency_ruble,
                                    //                             color: Color(0xFF12141F),
                                    //                             size: 8,
                                    //                           ),
                                    //                         ])),
                                    //                   ])));
                                    //         },
                                    //       ))
                                    // ]),
                                  ]);
                                }
                                return const Center(child: Text('no data'));
                              }))
                    ])),
                  );
                }),
                drawer: const NavDrawer(),
              ));
        });
  }
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

Future<CategoriesList> getCategoriesList() async {
  const url = baseUrl + '/test/categories_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint('response getCategoriesLists');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return CategoriesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
