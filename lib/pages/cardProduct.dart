import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cadillac/widgets/socials.dart';

import 'package:cadillac/models/products.dart';
import 'package:provider/provider.dart';

import '../variables.dart';
import 'data.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late Future<ProductsList> productsList;
  dynamic currentProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('cardProductAdmun');
    print(Provider
        .of<Data>(context, listen: false)
        .data['productId'].toString());
    String productId = Provider
        .of<Data>(context, listen: false)
        .data['productId'].toString();
    currentProduct = getProduct(productId, context);
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
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Shop()));
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
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
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
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    height: 330,
                                                    padding: EdgeInsets.zero,
                                                    margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                                    transformAlignment: Alignment.centerLeft,
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
                                                  //     customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 2)
                                                  //       ..addTranslate([
                                                  //         const Offset(-50.0, 0.0),
                                                  //         const Offset(160.0, 0.0),
                                                  //       ]),
                                                  //     viewportFraction: 1,
                                                  //     itemHeight: 279,
                                                  //     itemWidth: 260,
                                                  //     outer: true,
                                                  //     pagination: const SwiperPagination(
                                                  //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                  //         builder: DotSwiperPaginationBuilder(color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0)),
                                                  //     itemBuilder: (BuildContext context, int index) {
                                                  //       return Container(
                                                  //           width: 260,
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
                                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                    Container(
                                                      width: 284,
                                                      margin: const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Text(
                                                        "${snapshot.data?.productName}".toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 24,
                                                          color: Color(0xFF8F97BF),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 284,
                                                      child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
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
                                                    ),
                                                  ])
                                                ]),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                      Container(
                                                          margin: const EdgeInsets.only(top: 100, bottom: 15),
                                                          child: Text(
                                                            "Хотите такой товар?".toUpperCase(),
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
                                    ])));
                          }

                          return const Center(child: Text('no data'));
                        });
                  })));
        });
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
}