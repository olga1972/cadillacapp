import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cadillac/pages/homeAdmin.dart';
import 'package:cadillac/pages/membersAdmin.dart';
import 'package:cadillac/pages/newsAdmin.dart';
import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:cadillac/pages/shopAdmin.dart';
import 'package:cadillac/variables.dart';
import 'package:cadillac/widgets/titlePageAdmin.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../NavDrawerAdmin.dart';
import 'data.dart';
import 'editAccountAdmin.dart';
import 'gift.dart';

class AccountAdmin extends StatefulWidget {
//class Account extends StatefulWidget {

  const AccountAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountAdmin> createState() => _AccountAdminState();
}

class _AccountAdminState extends State<AccountAdmin> {
  late dynamic userId;
  late Uint8List base64Path;
  late File image;
  late File car1;
  late File car2;
  late File car3;
  late Uint8List data;

  bool isLoadedImage = false;

  late String value;
  late String currentId;
  dynamic user;

  late String platform;

  @override
  initState() {
    debugPrint('init state account');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('user account admin');

    userId = Provider.of<Data>(context).data['userId'].toString();
    debugPrint(userId);
    platform = Provider.of<Data>(context).data['platform'].toString();

    user = getUser(userId);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeAdmin(),
          '/members': (context) => const MembersAdmin(),
          '/news': (context) => const NewsAdmin(),
          '/shop': (context) => const ShopAdmin(),
          '/partners': (context) => const PartnersAdmin(),
        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
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
          actions: <Widget>[
            Container(
              width: 160,
              margin: const EdgeInsets.only(top: 22, right: 18.0),
              child: const Text(
                'Удалить аккаунт',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'CadillacSans',
                  color: Colors.white,
                  //height: 1.4, //line-height : font-size
                ),
              ),
            ),
            IconButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(0),
              iconSize: 22.0,
              icon: SvgPicture.asset(
                'assets/images/delete.svg',
                semanticsLabel: 'Icon delete',
                height: 15.0,
              ),
              onPressed: () {
                confirmDialog(context);
                // deleteUser(userId);
                // Route route = MaterialPageRoute(builder: (context) => const MembersAdmin());
                // Navigator.push(context, route);
              },
            ),
          ]),
          body: Consumer<Data>(
            builder: (context, data, child) {
              return FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.hasData) {
                    List<Uint8List> images = [];

                    late Uint8List bytesCar1;
                    late Uint8List bytesCar2;
                    late Uint8List bytesCar3;

                    if (snapshot.data?.path != null) {
                      isLoadedImage = true;
                    } else {
                      isLoadedImage = false;
                    }

                    if (snapshot.data?.car1 != null) {
                      var car1Encode = snapshot.data?.car1;
                      var car1Decode64 = base64.decode(car1Encode!);
                      bytesCar1 = car1Decode64;
                      if (bytesCar1.isNotEmpty) {
                        images.add(bytesCar1);
                      } else {
                        debugPrint('car1 no exist');
                      }
                    }

                    if (snapshot.data?.car2 != null) {
                      var car2Encode = snapshot.data?.car2;
                      var car2Decode64 = base64.decode(car2Encode!);
                      bytesCar2 = car2Decode64;

                      if (bytesCar2.isNotEmpty) {
                        images.add(bytesCar2);
                      } else {
                        debugPrint('car2 no exist');
                      }
                    }

                    if (snapshot.data?.car3 != null) {
                      var car3Encode = snapshot.data?.car3;
                      var car3Decode64 = base64.decode(car3Encode!);
                      bytesCar3 = car3Decode64;

                      if (bytesCar3.isNotEmpty) {
                        images.add(bytesCar3);
                      } else {
                        debugPrint('car3 no exist');
                      }
                    }

                    debugPrint('images.length');
                    debugPrint(images.length.toString());

                    return Center(
                      child: SizedBox(
                        width: 284,
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const TitlePageAdmin(title: 'аккаунт члена\nавтоклуба cadillac'),
                                Container(
                                    // height: 100,
                                    margin: const EdgeInsets.only(top: 43.0, bottom: 43.0),
                                    color: Colors.transparent,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 36,
                                                  margin: const EdgeInsets.only(
                                                    right: 28.0,
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: SvgPicture.asset('assets/images/account.svg', semanticsLabel: 'Icon author', height: 22.0),
                                                ),
                                                Text('${snapshot.data?.username}'.toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'CadillacSans',
                                                      color: Colors.white,
                                                      height: 1.4, //line-height : font-size
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                    height: 36,
                                                    alignment: Alignment.centerLeft,
                                                    child: IconButton(
                                                        alignment: Alignment.centerLeft,
                                                        padding: const EdgeInsets.all(0),
                                                        iconSize: 22.0,
                                                        icon: SvgPicture.asset(
                                                          'assets/images/gift.svg',
                                                          semanticsLabel: 'Icon gift',
                                                          height: 22.0,
                                                        ),
                                                        onPressed: () {
                                                          if (getDate(snapshot.data?.birthday)) {
                                                            Route route = MaterialPageRoute(builder: (context) => const Gift());
                                                            Navigator.push(context, route);
                                                          } else {
                                                            alertDialog(context);
                                                          }
                                                        })),
                                                Text('${snapshot.data?.birthday}'.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: 'CadillacSans',
                                                      color: Colors.white,
                                                      height: 1.4, //line-height : font-size
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 36,
                                                    alignment: Alignment.centerLeft,
                                                    child: IconButton(
                                                      alignment: Alignment.centerLeft,
                                                      padding: const EdgeInsets.all(0),
                                                      iconSize: 22.0,
                                                      icon: SvgPicture.asset(
                                                        'assets/images/edit.svg',
                                                        semanticsLabel: 'Icon edit',
                                                        height: 22.0,
                                                        color: const Color(0xFF515569),
                                                      ),
                                                      onPressed: () {
                                                        Route route = MaterialPageRoute(builder: (context) => EditAdmin());
                                                        Navigator.push(context, route);
                                                      },
                                                    )),
                                                const Text(
                                                  'Изменить данные',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Color(0xFF515569),
                                                    height: 1.4, //line-height : font-size
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                      ClipOval(
                                        child: CircleAvatar(
                                            radius: 48,
                                            backgroundColor: Colors.transparent,
                                            child: (snapshot.data?.path != null)
                                                ? Image.memory(base64.decode(snapshot.data?.path ?? ''), fit: BoxFit.cover, width: 96, height: 96)
                                                : const Text('no image')),
                                      ),
                                    ])),
                                Text('ваш именной номер'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'CadillacSans',
                                      color: Colors.white,
                                      height: 1.4, //line-height : font-size
                                    )),
                                Container(
                                  width: 284,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF515569),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(top: 10, bottom: 25),
                                  child: Text('${snapshot.data?.id}'.toString().padLeft(4, '0').toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'CadillacSans',
                                        color: Colors.white,
                                      )),
                                ),
                                Text('ваш автомобиль'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'CadillacSans',
                                      color: Colors.white,
                                      height: 1.5, //line-height : font-size
                                    )),
                                Text('${snapshot.data?.carname}'.toUpperCase(),
                                    // Text('cadillac'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'CadillacSans',
                                      color: Colors.white,
                                      height: 1.17,
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 160,
                                    padding: EdgeInsets.zero,
                                    margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                    color: const Color(0xFF2C335E),
                                    child: images.length == 1
                                        ? Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                child: Image.memory(
                                                  images[0],
                                                  width: 285,
                                                  height: 160,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.centerLeft,
                                                )))
                                        : Swiper(
                                            layout: SwiperLayout.CUSTOM,
                                            customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 2)
                                              ..addTranslate([
                                                const Offset(0.0, 0.0),
                                                const Offset(284.0, 0.0),
                                              ]),
                                            itemCount: images.length,
                                            viewportFraction: 0.8,
                                            itemHeight: 160,
                                            itemWidth: 284,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  ),
                                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                                  child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                      child: Image.memory(
                                                        images[index],
                                                        width: 284,
                                                        height: 160,
                                                        fit: BoxFit.cover,
                                                        alignment: Alignment.centerLeft,
                                                      )));
                                            },
                                            pagination: const SwiperPagination(
                                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                                                builder: DotSwiperPaginationBuilder(
                                                    color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0)))),
                              ])))
                            ])));
                  }

                  return const Center(child: Text('no data'));
                },
              );
            },
          ),
          drawer: const NavDrawerAdmin(),
        ));
  }
}

Future<User> getUser(userId) async {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // dynamic userId = prefs.getString("userId");

  debugPrint('getUser admin');
  debugPrint('userId: $userId');

  String apiUrl = baseUrl + "/test/get_user.php";

  final response = await http.post(Uri.parse(apiUrl), body: {
    'userId': userId
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  if (response.statusCode == 200) {
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    var cookie = response.headers['set-cookie'];
    debugPrint('cookie account admin: $cookie');

    // debugPrint(response);
    final userJson = json.decode(response.body);
    debugPrint(User.fromJson(userJson).username);

    var data = User.fromJson(userJson);
    return (data);
  } else {
    throw Exception('Error fetching users');
  }
}

deleteUser(userId) async {
  debugPrint('delete user admin');
  String apiUrl = baseUrl + "/test/delete_user.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
    'userId': userId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    debugPrint('user deleted');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    return response.body;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

Future confirmDialog(BuildContext context, userId) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Удалить аккаунт?'.toUpperCase(),
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
                    deleteUser(userId);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MembersAdmin()));
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

getDate(date) {
  debugPrint('getDate');
  DateTime now = DateTime.now();
  var formatter = DateFormat('dd.MM');
  String formattedDate = formatter.format(now);
  debugPrint(formattedDate); // 26.01.2016
  debugPrint(date);
  String currentDate = date.substring(0, date.length - 5);
  debugPrint(currentDate);
  if (formattedDate == currentDate) {
    return true;
  } else {
    return false;
  }
}

Future alertDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text(
          'Подарок вы получите в свой день рождения!'.toUpperCase(),
          textAlign: TextAlign.center,
          style: styleTextAlertDialog,
        ),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                    'Закрыть'.toUpperCase(),
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
