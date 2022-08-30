import 'dart:convert';

import 'package:http/http.dart' as http;
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
import 'package:provider/provider.dart';

import 'addProduct.dart';
import 'data.dart';

class CardProductAdmin extends StatefulWidget {
  const CardProductAdmin({Key? key,}) : super(key: key);

  @override
  State<CardProductAdmin> createState() => _CardProductAdminState();
}

class _CardProductAdminState extends State<CardProductAdmin> {
  late Future<ProductsList> productsList;
  dynamic currentProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('cardProductAdmun');
    print(Provider.of<Data>(context, listen: false).data['productId'].toString());
    String productId = Provider.of<Data>(context, listen: false).data['productId'].toString();
    currentProduct = getProduct(productId, context);
    return ChangeNotifierProvider<Data> (
        create: (context) => Data(),
    builder: (context, child) {
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
    body: Consumer<Data>(builder: (context, data, child) {
            return FutureBuilder<Product>(
                //return FutureBuilder<User>(
                future: currentProduct,
                builder: (context, snapshot) {
                  print(productId);
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.hasData) {
                    print(snapshot.data);

                    return Center(
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
                                    child: Container(
                                        width: 260,
                                        height: 279,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                          child: Image.memory(base64.decode(snapshot.data?.productImage ?? ''),
                                              fit: BoxFit.contain),

                                          ),
                                        )
                                    // child: Swiper(
                                    //     itemCount: 2,
                                    //     allowImplicitScrolling: true,
                                    //     layout: SwiperLayout.CUSTOM,
                                    //     customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 2)
                                    //       ..addTranslate([
                                    //         const Offset(-50.0, 0.0),
                                    //         const Offset(160.0, 0.0),
                                    //       ]),
                                    //     viewportFraction: 0.8,
                                    //     itemHeight: 279,
                                    //     itemWidth: 260,
                                    //     outer: true,
                                    //     pagination: const SwiperPagination(
                                    //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    //         builder: DotSwiperPaginationBuilder(color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0)),
                                    //     itemBuilder: (BuildContext context, int index) {
                                    //       return Container(
                                    //           width: MediaQuery.of(context).size.width,
                                    //           height: 279,
                                    //           margin: const EdgeInsets.only(left: 0, right: 10),
                                    //           decoration: const BoxDecoration(
                                    //             color: Colors.transparent,
                                    //             borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //           ),
                                    //           child: ClipRRect(
                                    //             borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    //             child: Image.asset(
                                    //               images[index],
                                    //               fit: BoxFit.contain,
                                    //             ),
                                    //           ));
                                    //     }),
                                    ),
                                SizedBox(
                                  width: 320,
                                  height: 45,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Text(
                                      "${snapshot.data?.productName}".toUpperCase(),
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
                                        var productId = snapshot.data?.productId;
                                        confirmDialog(context, productId);
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
                                      Row(children: [
                                        Text(
                                          "${snapshot.data?.productPrice} ",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Icon(
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
                                            Route route = MaterialPageRoute(
                                                builder: (
                                                    context) => const AddProduct());
                                            Navigator.push(context, route);
                                        },
                                      )
                                    ])),
                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Container(
                                        margin: const EdgeInsets.only(top: 100, bottom: 15),
                                        child: Text(
                                          "Хотите такой товар?".toUpperCase(),
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
                            ])));
                  }
                  return const Center(child: Text('no data'));
                });})));
  });}
}

deleteProduct(productId) async {
  debugPrint('delete product admin');
  String apiUrl = baseUrl + "/test/delete_product.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
    'productId': productId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    debugPrint('product deleted');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    return response.body;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

Future confirmDialog(BuildContext context, productId) async {
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
                    deleteProduct(productId);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopAdmin()));
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

Future<Product> getProduct(productId, context) async {
  const url = baseUrl + '/test/get_product.php';
  final response = await http.post(Uri.parse(url), body: {
    'productId': productId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "http://localhost:59369",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  debugPrint('response getProduct');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return Product.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
