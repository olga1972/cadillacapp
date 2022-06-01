// import 'package:cadillac/models/productsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/productsList.dart';
import 'package:cadillac/models/products.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

@override
State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  //late Future<OfficesList> officesList;
  late Future<ProductsList> productsList;

  get currentUser => null;

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    productsList = readJson();
    // setState(() {
    //   _items = data["items"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          // '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),

        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
          ),

            // final List<DocumentSnapshot> userList = snapshot.data.documents
            // .where((DocumentSnapshot documentSnapshot) => documentSnapshot['userId'] != id).toList();

          body: FutureBuilder<ProductsList>(
              future: productsList,
              builder: (context, snapshot) {
                print('snapshot.data.products');
                var products = snapshot.data?.products;
                final List<Product>? productsList = snapshot.data?.products
                    .where((p) => p.categoryId != 1).toList();
                print(productsList);
                // fruits.where((f) => f.startsWith('a')).toList(); //apples
                // products.where((p) => p.category = products[0]?.category).toList();
                final selectedCategory = snapshot.data?.products.where((u) => u.category.contains('футболка')).toList();
                // print(snapshot.data?.products[0].category);
                print(selectedCategory);
                if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.products.length,
                      //   itemCount: selectedCategory?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('${snapshot.data?.products[index]?.name}'),
                              subtitle:
                              Text('${snapshot.data?.products[index]?.category}'),
                              leading: Image.network(
                                  '${snapshot.data?.products[index].image}'),
                              isThreeLine: true,
                            ),
                          );
                        });

                } else if (snapshot.hasError) {
                  print(snapshot.data);
                  return const Text('Error');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          //),


          // body: Center (
          //     child: Container (
          //       alignment: Alignment.topCenter,
          //         // width: 284,
          //
          //         child: Column (
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               const TitlePage(title: 'клубная атрибутика'),
          //               FutureBuilder<ProductsList>(
          //                 future: productsList,
          //                 builder: (context, AsyncSnapshot snapshot) {
          //                   // if (snapshot.connectionState == ConnectionState.waiting) {
          //                   //   return const Center(
          //                   //     child: CircularProgressIndicator(),
          //                   //   );
          //                   // }
          //                   // if (snapshot.connectionState == ConnectionState.done) if (snapshot.hasError) {
          //                   if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
          //                     return Container(
          //                       // height: 100,
          //                         margin: const EdgeInsets.only(
          //                             top: 43.0, bottom: 43.0),
          //                         // color: Colors.transparent,
          //                         child: ListView.builder(
          //                             itemCount: snapshot.data?.products.length,
          //                             itemBuilder: (context, index) {
          //                               return Row(
          //                                   children: [
          //                                       Expanded(
          //                                           flex: 1,
          //                                           child: Container(
          //                                               height: 172,
          //                                               margin: const EdgeInsets.only(
          //                                                   right: 25.0),
          //                                               padding: const EdgeInsets.only(
          //                                                   left: 5.0, right: 5.0),
          //                                               alignment: Alignment.center,
          //                                               child: Text('${snapshot.data?.products[index].category}'.toUpperCase(),
          //                                               textAlign: TextAlign.center,
          //                                               style: const TextStyle(
          //                                                 fontSize: 14.0,
          //                                                 fontWeight: FontWeight.normal,
          //                                                 fontFamily: 'CadillacSans',
          //                                                 color: Colors.white,
          //                                                 height: 1.4, //line-height : font-size
          //                                                   )
          //                                               )
          //                                           ),
          //                                       ),
          //                                       const Expanded(
          //                                           flex: 2,
          //                                           child: Text('slider'),
          //                                       )
          //
          //                                   ],
          //                               );
          //                             }
          //                         )
          //                     );
          //                   }
          //
          //                   if (snapshot.data != null) {
          //                     return snapshot.data;
          //                   } else {
          //                     return const Center(
          //                       child: CircularProgressIndicator(),
          //                     );
          //                   }
          //
          //                   if (snapshot.hasData) {
          //                     return ListView.builder(
          //                         itemCount: snapshot.data?.products.length,
          //                         itemBuilder: (context, index) {
          //                           return  Container(
          //                             // height: 100,
          //                               margin: const EdgeInsets.only(top: 43.0, bottom: 43.0),
          //                               // color: Colors.transparent,
          //                               child: Row (
          //                                   children: [
          //                                       Expanded(
          //                                         flex: 1,
          //                                         child: Container (
          //                                             height: 172,
          //                                             margin: const EdgeInsets.only(right: 25.0),
          //                                             padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          //                                             alignment: Alignment.center,
          //                                             child: Text('${snapshot.data?.products[index].category}'.toUpperCase(),
          //                                                 textAlign: TextAlign.center,
          //                                                 style: const TextStyle(
          //                                                   fontSize: 14.0,
          //                                                   fontWeight: FontWeight.normal,
          //                                                   fontFamily: 'CadillacSans',
          //                                                   color: Colors.white,
          //                                                   height: 1.4, //line-height : font-size
          //                                                 )
          //                                             )
          //                                         ),
          //                                       ),
          //                                       Expanded(
          //                                         flex: 2,
          //                                           child: Text('slider'),
          //                                       )
          //
          //                                    ],
          //                               ),
          //
          //                             );
          //                           }
          //                         );
          //                     }
          //                 }
          //               )
          //            ]
          //         )
          //     )
          //
          //  ),

          drawer: NavDrawer(),
        )
    );
  }
}