// import 'package:cadillac/models/productsList.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:cadillac/pages/account.dart';

import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/productsList.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';
import '../variables.dart';
import 'cardProduct.dart';
import 'cardProductAdmin.dart';

class ShopAdmin extends StatefulWidget {
  const ShopAdmin({Key? key}) : super(key: key);

  @override
  State<ShopAdmin> createState() => _ShopAdminState();
}

class _ShopAdminState extends State<ShopAdmin> {
  //late Future<OfficesList> officesList;
  late Future<ProductsList> productsList;

  // get currentUser => null;
  List<String> images = [
    "assets/images/t-shirt.png",
    "assets/images/hoodie.png",
    "assets/images/notebook.png",
  ];

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
    var width = MediaQuery.of(context).size.width - 130;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: const {
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
            backgroundColor: const Color(0xFF2C335E),
            shadowColor: const Color(0xFF2C335E),
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          body: Center (
              child: ListView (
                children: [
                  Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container (
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 30, bottom: 20),
                          child: const TitlePage(title: 'клубная атрибутика'),
                        ),
                        Container (
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width,
                            child: Column (
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row (
                                    children: [
                                      Container (
                                        margin: const EdgeInsets.only(bottom: 30),
                                        //padding: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 130,
                                        height: 200,
                                        child: Text("Футболки".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 14,

                                            color: Colors.white,
                                            // color: Color(
                                            //     0xFF12141F)
                                          ),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),

                                      Container (
                                        // width: MediaQuery.of(context).size.width,
                                          width: width,
                                          height: 200,

                                          //padding: EdgeInsets.only(bottom: 10),
                                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                          child: Container(
                                            child: Swiper(
                                              itemCount: 3,
                                              // control: SwiperControl(),
                                              layout: SwiperLayout.CUSTOM,

                                              customLayoutOption:
                                              CustomLayoutOption(startIndex: -1, stateCount: 3)..addTranslate([
                                                const Offset(-71.0, 0.0),
                                                const Offset(40.0, 0.0),
                                                const Offset(151.0, 0.0)
                                              ]),
                                              //fade: 0.2,
                                              //allowImplicitScrolling: true,
                                              // duration: 3,
                                              //containerHeight: 160,
                                              //containerWidth: 280,
                                              viewportFraction: 0.43,
                                              itemHeight: 200,
                                              itemWidth: 98,
                                              autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                              outer: true,
                                              itemBuilder: (BuildContext context, int index) {

                                                return Container(
                                                    width: 98,
                                                    height: 190,
                                                    // margin: const EdgeInsets.only(left: 10,right: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE4E4FF),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                    child: Column (
                                                        children: [
                                                          Container(
                                                              width: 98,
                                                              height: 132,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              ),

                                                              child: IconButton(
                                                                icon: Image.asset(
                                                                  images[index],
                                                                  //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                                                  fit: BoxFit.contain,
                                                                  // alignment: Alignment.topLeft,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                          // Card(productId: 1)));
                                                                          const CardProductAdmin()));
                                                                },
                                                              )
                                                          ),
                                                          Container (
                                                              width: 98,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              //padding: EdgeInsets.zero,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffE4E6FF),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10.0),
                                                                  bottomRight: Radius.circular(10.0),

                                                                ),
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("Блокноты ".toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 7,
                                                                          letterSpacing: 0,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,

                                                                    ),
                                                                    IconButton( icon: const Icon(Icons.add, size: 10,),
                                                                      //iconSize: 48,
                                                                      color: const Color( 0xFF12141F),
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () {
                                                                        print('add');
                                                                      },
                                                                    ),
                                                                  ]
                                                              )
                                                            //)
                                                          ),
                                                          Container (
                                                              width: 88,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: const [
                                                                    Text("2500 ",
                                                                      style: TextStyle(
                                                                          fontSize: 7,
                                                                          //color: Colors.white,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    Icon( Icons.currency_ruble,
                                                                      color: Color( 0xFF12141F),
                                                                      size: 8,),
                                                                  ]
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                );

                                              },
                                              // indicatorLayout: PageIndicatorLayout.COLOR,

                                            ),

                                          )
                                      )

                                    ]

                                ),
                                Row (
                                    children: [
                                      Container (
                                        margin: const EdgeInsets.only(bottom: 30),
                                        //padding: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 130,
                                        height: 200,
                                        child: Text("Худи".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 14,

                                            color: Colors.white,
                                            // color: Color(
                                            //     0xFF12141F)
                                          ),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),

                                      Container (
                                        // width: MediaQuery.of(context).size.width,
                                          width: width,
                                          height: 200,

                                          //padding: EdgeInsets.only(bottom: 10),
                                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                          child: Container(
                                            child: Swiper(
                                              itemCount: 3,
                                              // control: SwiperControl(),
                                              layout: SwiperLayout.CUSTOM,

                                              customLayoutOption:
                                              CustomLayoutOption(startIndex: -1, stateCount: 3)..addTranslate([
                                                const Offset(-71.0, 0.0),
                                                const Offset(40.0, 0.0),
                                                const Offset(151.0, 0.0)
                                              ]),
                                              //fade: 0.2,
                                              //allowImplicitScrolling: true,
                                              // duration: 3,
                                              //containerHeight: 160,
                                              //containerWidth: 280,
                                              viewportFraction: 0.43,
                                              itemHeight: 200,
                                              itemWidth: 98,
                                              autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                              outer: true,
                                              itemBuilder: (BuildContext context, int index) {

                                                return Container(
                                                    width: 98,
                                                    height: 190,
                                                    // margin: const EdgeInsets.only(left: 10,right: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE4E4FF),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                    child: Column (
                                                        children: [
                                                          Container(
                                                              width: 98,
                                                              height: 132,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              ),

                                                              child: IconButton(
                                                                icon: Image.asset(
                                                                  images[index],
                                                                  //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                                                  fit: BoxFit.contain,
                                                                  // alignment: Alignment.topLeft,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                          // Card(productId: 1)));
                                                                          const CardProduct()));
                                                                },
                                                              )
                                                          ),
                                                          Container (
                                                              width: 98,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              //padding: EdgeInsets.zero,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffE4E6FF),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10.0),
                                                                  bottomRight: Radius.circular(10.0),

                                                                ),
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("Блокноты ".toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 7,
                                                                          letterSpacing: 0,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,

                                                                    ),
                                                                    IconButton( icon: const Icon(Icons.add, size: 10,),
                                                                      //iconSize: 48,
                                                                      color: const Color( 0xFF12141F),
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () {
                                                                        print('add');
                                                                      },
                                                                    ),
                                                                  ]
                                                              )
                                                            //)
                                                          ),
                                                          Container (
                                                              width: 88,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: const [
                                                                    Text("2500 ",
                                                                      style: TextStyle(
                                                                          fontSize: 7,
                                                                          //color: Colors.white,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    Icon( Icons.currency_ruble,
                                                                      color: Color( 0xFF12141F),
                                                                      size: 8,),
                                                                  ]
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                );

                                              },
                                              // indicatorLayout: PageIndicatorLayout.COLOR,

                                            ),

                                          )
                                      )

                                    ]

                                ),
                                Row (
                                    children: [
                                      Container (
                                        margin: const EdgeInsets.only(bottom: 30),
                                        //padding: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 130,
                                        height: 200,
                                        child: Text("Блокноты".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 14,

                                            color: Colors.white,
                                            // color: Color(
                                            //     0xFF12141F)
                                          ),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),

                                      Container (
                                        // width: MediaQuery.of(context).size.width,
                                          width: width,
                                          height: 200,

                                          //padding: EdgeInsets.only(bottom: 10),
                                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                          child: Container(
                                            child: Swiper(
                                              itemCount: 3,
                                              // control: SwiperControl(),
                                              layout: SwiperLayout.CUSTOM,

                                              customLayoutOption:
                                              CustomLayoutOption(startIndex: -1, stateCount: 3)..addTranslate([
                                                const Offset(-71.0, 0.0),
                                                const Offset(40.0, 0.0),
                                                const Offset(151.0, 0.0)
                                              ]),
                                              //fade: 0.2,
                                              //allowImplicitScrolling: true,
                                              // duration: 3,
                                              //containerHeight: 160,
                                              //containerWidth: 280,
                                              viewportFraction: 0.43,
                                              itemHeight: 200,
                                              itemWidth: 98,
                                              autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                              outer: true,
                                              itemBuilder: (BuildContext context, int index) {

                                                return Container(
                                                    width: 98,
                                                    height: 190,
                                                    // margin: const EdgeInsets.only(left: 10,right: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE4E4FF),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                    child: Column (
                                                        children: [
                                                          Container(
                                                              width: 98,
                                                              height: 132,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              ),

                                                              child: IconButton(
                                                                icon: Image.asset(
                                                                  images[index],
                                                                  //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                                                  fit: BoxFit.contain,
                                                                  // alignment: Alignment.topLeft,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                          // Card(productId: 1)));
                                                                          const CardProduct()));
                                                                },
                                                              )
                                                          ),
                                                          Container (
                                                              width: 98,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              //padding: EdgeInsets.zero,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffE4E6FF),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10.0),
                                                                  bottomRight: Radius.circular(10.0),

                                                                ),
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("Блокноты ".toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 7,
                                                                          letterSpacing: 0,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,

                                                                    ),
                                                                    IconButton( icon: const Icon(Icons.add, size: 10,),
                                                                      //iconSize: 48,
                                                                      color: const Color( 0xFF12141F),
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () {
                                                                        print('add');
                                                                      },
                                                                    ),
                                                                  ]
                                                              )
                                                            //)
                                                          ),
                                                          Container (
                                                              width: 88,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: const [
                                                                    Text("2500 ",
                                                                      style: TextStyle(
                                                                          fontSize: 7,
                                                                          //color: Colors.white,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    Icon( Icons.currency_ruble,
                                                                      color: Color( 0xFF12141F),
                                                                      size: 8,),
                                                                  ]
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                );

                                              },
                                              // indicatorLayout: PageIndicatorLayout.COLOR,

                                            ),

                                          )
                                      )

                                    ]

                                ),
                                Row (
                                    children: [
                                      Container (
                                        margin: const EdgeInsets.only(bottom: 30),
                                        //padding: EdgeInsets.only(left: 50),
                                        alignment: Alignment.center,
                                        width: 130,
                                        height: 200,
                                        child: Text("Наклейки".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 14,

                                            color: Colors.white,
                                            // color: Color(
                                            //     0xFF12141F)
                                          ),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),

                                      Container (
                                        // width: MediaQuery.of(context).size.width,
                                          width: width,
                                          height: 200,

                                          //padding: EdgeInsets.only(bottom: 10),
                                          margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                          child: Container(
                                            child: Swiper(
                                              itemCount: 3,
                                              // control: SwiperControl(),
                                              layout: SwiperLayout.CUSTOM,

                                              customLayoutOption:
                                              CustomLayoutOption(startIndex: -1, stateCount: 3)..addTranslate([
                                                const Offset(-71.0, 0.0),
                                                const Offset(40.0, 0.0),
                                                const Offset(151.0, 0.0)
                                              ]),
                                              //fade: 0.2,
                                              //allowImplicitScrolling: true,
                                              // duration: 3,
                                              //containerHeight: 160,
                                              //containerWidth: 280,
                                              viewportFraction: 0.43,
                                              itemHeight: 200,
                                              itemWidth: 98,
                                              autoplay: MediaQuery.of(context).size.width > 920 ? true : false,
                                              outer: true,
                                              itemBuilder: (BuildContext context, int index) {

                                                return Container(
                                                    width: 98,
                                                    height: 190,
                                                    // margin: const EdgeInsets.only(left: 10,right: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE4E4FF),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                    child: Column (
                                                        children: [
                                                          Container(
                                                              width: 98,
                                                              height: 132,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              ),

                                                              child: IconButton(
                                                                icon: Image.asset(
                                                                  images[index],
                                                                  //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                                                  fit: BoxFit.contain,
                                                                  // alignment: Alignment.topLeft,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                          // Card(productId: 1)));
                                                                          const CardProduct()));
                                                                },
                                                              )
                                                          ),
                                                          Container (
                                                              width: 98,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              //padding: EdgeInsets.zero,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffE4E6FF),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10.0),
                                                                  bottomRight: Radius.circular(10.0),

                                                                ),
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("Блокноты ".toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 7,
                                                                          letterSpacing: 0,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,

                                                                    ),
                                                                    IconButton( icon: const Icon(Icons.add, size: 10,),
                                                                      //iconSize: 48,
                                                                      color: const Color( 0xFF12141F),
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () {
                                                                        print('add');
                                                                      },
                                                                    ),
                                                                  ]
                                                              )
                                                            //)
                                                          ),
                                                          Container (
                                                              width: 88,
                                                              padding: const EdgeInsets.only(left: 5),
                                                              child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: const [
                                                                    Text("2500 ",
                                                                      style: TextStyle(
                                                                          fontSize: 7,
                                                                          //color: Colors.white,
                                                                          color: Color(
                                                                              0xFF12141F)
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    Icon( Icons.currency_ruble,
                                                                      color: Color( 0xFF12141F),
                                                                      size: 8,),
                                                                  ]
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                );

                                              },
                                              // indicatorLayout: PageIndicatorLayout.COLOR,

                                            ),

                                          )
                                      )

                                    ]

                                ),

                                Container(
                                    width: 380,
                                    margin: const EdgeInsets.only(left: 15),
                                    alignment: const Alignment(-1, 1),
                                    child: IconButton(
                                      alignment: Alignment
                                          .centerLeft,
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 20.0,
                                      icon: SvgPicture
                                          .asset(
                                        'assets/images/delete.svg',
                                        semanticsLabel: 'Icon delete',
                                        height: 20.0,

                                      ),
                                      onPressed: () {
                                        confirmDialog(context);
                                        //   Route route = MaterialPageRoute(
                                        //       builder: (
                                        //           context) => const Gift());
                                        //   Navigator
                                        //       .push(
                                        //       context,
                                        //       route);
                                      },
                                    )
                                ),
                                Container(
                                    width: 380,
                                    margin: const EdgeInsets.only(left: 15),
                                    alignment: const Alignment(-1, 1),
                                    child: IconButton(
                                      alignment: Alignment
                                          .centerLeft,
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 20.0,
                                      icon: SvgPicture
                                          .asset(
                                        'assets/images/add.svg',
                                        semanticsLabel: 'Icon add',
                                        height: 20.0,

                                      ),
                                      onPressed: () {

                                        //   Route route = MaterialPageRoute(
                                        //       builder: (
                                        //           context) => const Gift());
                                        //   Navigator
                                        //       .push(
                                        //       context,
                                        //       route);
                                      },
                                    )
                                )
                              ],
                            )
                        ),
                      ]

                  )
                ],

              )

          ),


          drawer: const NavDrawerAdmin(),
        )
    );
  }
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Удалить товар?'.toUpperCase(),
          textAlign: TextAlign.center,
          style: styleTextAlertDialog,
        ),
        actions: <Widget>[
          Container (
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        'Да'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        var userId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Account()));
                      },
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFE4E6FF),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),),
                      child: Text(
                        'Нет'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]
              )
          )


        ],
      );
    },
  );
}