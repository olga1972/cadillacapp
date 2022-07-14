import 'package:cadillac/pages/shopAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePage.dart';


// import 'package:cadillac/models/productsList.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cadillac/pages/account.dart';

import 'package:cadillac/widgets/socials.dart';

// import 'package:cadillac/widgets/productsList.dart';
import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

import '../variables.dart';


class CardProductAdmin extends StatefulWidget {
  // var productId;

  const CardProductAdmin({Key? key, }) : super(key: key);

  @override
  State<CardProductAdmin> createState() => _CardProductAdminState();
}

class _CardProductAdminState extends State<CardProductAdmin> {

  late Future<ProductsList> productsList;

  get currentUser => null;
  List<String> images = [
    "assets/images/notebook.png",
    "assets/images/notebook.png",

  ];

  @override
  void initState() {
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();

    // productsList = readJson();
    // setState(() {
    //   _items = data["items"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),

        },
        home: Scaffold(

            appBar: AppBar(
              backgroundColor: const Color(0xFF2C335E),
              shadowColor: Colors.transparent,
              elevation: 0.0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    // icon: SvgPicture.network('assets/images/burger.svg'),
                    onPressed: () {

                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (context) =>
                                   const ShopAdmin()
                        // SuccessPayment(
                        //     currentUser: user),
                      )
                      );

                    },


                  );
                },
              ),
            ),

            body: Center (
              child: Container (
                width: 320,
                height: 870,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Expanded (
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container (
                                width: 284,
                                margin: const EdgeInsets.only(top: 30, bottom: 70),
                                child: const TitlePage(title: 'клубная атрибутика'),
                              ),
                              Column (
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 320,
                                      height: 279,
                                      padding: EdgeInsets.zero,
                                      margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                      child: Swiper(

                                          itemCount: 2,
                                          // control: SwiperControl(),
                                          allowImplicitScrolling: true,
                                          //containerHeight: 160,
                                          //containerWidth: 390,
                                          viewportFraction: 0.8,
                                          itemHeight: 279,
                                          itemWidth: 332,
                                          autoplay: true,
                                          outer: true,
                                          pagination: const SwiperPagination(
                                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                                              builder: DotSwiperPaginationBuilder(
                                                  color: Colors.white,
                                                  activeColor: Color(0xFF8F97BF),
                                                  size: 7.0,
                                                  activeSize: 7.0
                                              )
                                          ),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              width: 332,
                                              height: 279,
                                              margin: const EdgeInsets.only(left: 0, right: 10),
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  child: Image.asset(images[index],
                                                    //centerSlice: Rect.fromPoints(const Offset(0.0, 0.0), const Offset(0, 0)),
                                                    fit: BoxFit.contain,
                                                    // alignment: Alignment.topLeft,
                                                  ),
                                                )

                                            );
                                          }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container (
                                                alignment: const Alignment(-1, 0),
                                                margin: const EdgeInsets.only(bottom: 20),
                                                child: Text("Блокнот".toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xFF8F97BF)
                                                  ),
                                                  textAlign: TextAlign.left,
                                                )
                                            ),
                                            Container(
                                                //width: 284,
                                                margin: const EdgeInsets.only(left: 15),
                                                child: IconButton(
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
                                                    //   Navigator.push(context, route);
                                                  },
                                                )

                                            ),
                                          ]
                                      ),
                                    ),


                                    SizedBox(
                                        width: 320,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 320,
                                                  //margin: const EdgeInsets.only(right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      //width: 120,
                                                      child: Row(
                                                        children: const [
                                                          Text("3700 ",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          Icon( Icons.currency_ruble,
                                                            color: Colors.white,
                                                            size: 24,),
                                                        ]
                                                      )
                                                    ),

                                                    Container(
                                                      //margin: const EdgeInsets.only(left: 15),
                                                        //alignment: Alignment(1, 1),
                                                        child: IconButton(
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
                                                            //   Navigator.push(context, route);
                                                          },
                                                        )
                                                    )


                                                  ]
                                                )


                                              ),
                                            ]
                                        ),
                                    ),
                                    Container (
                                        child: Column (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container (
                                                  margin: const EdgeInsets.only(top: 100, bottom: 15),
                                                  child: Text("Хотите такой блокнот?".toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                              ),
                                              Container (
                                                margin: const EdgeInsets.only(bottom: 15),
                                                child: const TitlePage(title: 'Напишите нам'),
                                              ),
                                              const Socials()
                                            ]
                                        )
                                    )

                                  ]
                              )


                          ]
                      )
                    )
                )
            ]
    )
    )
    )
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