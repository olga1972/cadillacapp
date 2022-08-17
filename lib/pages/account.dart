import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/pages/contacts.dart';
import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/registrationPage.dart';
import 'package:cadillac/pages/renewAccount.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/variables.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cadillac/models/users.dart';
import 'package:cadillac/pages/data.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/gift.dart';

import '../services/auth.dart';

//class Account extends StatelessWidget {
class Account extends StatefulWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late dynamic userId='5gOD8E3TlCfnjTW1Aso1VvjiG9C3';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('user account');
    // debugPrint(Provider
    //     .of<Data>(context, listen: false)
    //     .data['counter'].toString());

    //userId = Provider.of<Data>(context, listen: false).data['userId'].toString();
    //debugPrint(userId);
    //platform = Provider.of<Data>(context).data['platform'].toString();
    //debugPrint(platform);

    List<Cookie> cookies = [Cookie("uuid", "$userId")];

    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    //Save cookies
    cookieJar.saveFromResponse(Uri.parse(baseUrl), cookies);

    var response = getCookie();
    debugPrint('cookies account');
    //debugPrint(response); error

    user = getUser(userId, context);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const Home(),
          '/members': (context) => const Members(),
          '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          '/gift': (context) => const Gift(),
        },
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
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    AuthService().logOut();
                  },
                  icon: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                  )
            ],
          ),
          // body: Consumer<Data>(builder: (context, data, child) {
    body: FutureBuilder<User> (
            //return FutureBuilder<User>(
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
                                const TitlePage(title: 'мой аккаут \nавтоклуба cadillac'),
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
                                                        Route route = MaterialPageRoute(builder: (context) => Edit());
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
                                      height: 1.4,
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
                                      height: 1.5,
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
                                  color: const Color(0xFF181C33),
                                  child: images.length == 1
                                      ? Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              child: Image.memory(
                                                images[0],
                                                width: 284,
                                                height: 160,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.centerLeft,
                                              )))
                                      : Swiper(
                                          layout: SwiperLayout.CUSTOM,
                                          customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 2)
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
                                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                                              builder:
                                                  DotSwiperPaginationBuilder(color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0))),
                                ),
                              ])))
                            ])));
                  }
                  return const Center(child: Text('no data'));
                }),


          drawer: const NavDrawer(),
        ));
  }
}

Future<User> getUser(userId, context) async {
  debugPrint('getUser');
  debugPrint('userId: $userId');

  String apiUrl = baseUrl + "/test/get_user.php";

  final response = await http.post(Uri.parse(apiUrl), body: {
    'userId': userId
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "http://localhost:59369",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  if (response.statusCode == 200) {
    final userJson = json.decode(response.body);

    checkAccount(User.fromJson(userJson).dateExpired, context);

    var data = User.fromJson(userJson);
    debugPrint(data.dateExpired);

    return (data);
  } else {
    throw Exception('Error fetching users');
  }
}

getCookie() async {
  debugPrint('get cookie');
  var dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  // Get cookies
  //var cookies = cookieJar.loadForRequest(Uri.parse("https://cadillacapp.ru/"));

  // second request with the cookie
  var response = await dio.get("https://cadillacapp.ru/");
  if (kDebugMode) {
    print(response);
  }

  return response;
}

getDate(date) {
  DateTime now = DateTime.now();
  var formatter = DateFormat('dd.MM');
  String formattedDate = formatter.format(now);

  String currentDate = date.substring(0, date.length - 5);

  if (formattedDate == currentDate) {
    return true;
  } else {
    return false;
  }
}

checkAccount(dateExpired, context) {
  debugPrint('check account');
  dynamic isShowWarning;

  debugPrint(dateExpired);

  DateTime expired = DateFormat("yyyy-MM-dd hh:mm").parse(dateExpired);

  DateTime dateNow = DateTime.now().toLocal();

  var difference = expired.difference(dateNow);

  debugPrint(difference.inDays.toString());

  if (difference.inDays <= 5 && isShowWarning == 'false') {
    debugPrint('invalid');
    isShowWarning == true;
    warningDialog(context, difference.inDays);
  } else if (difference.inDays < 0) {
    isShowWarning == false;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  } else {
    debugPrint('valid');

    isShowWarning == false;
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

Future warningDialog(context, difference) async {
  late String days;
  if (difference == 5) {
    days = 'дней';
  } else if (difference == 1) {
    days = 'день';
  } else {
    days = 'дня';
  }

  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Уведомление'.toUpperCase(), textAlign: TextAlign.center),
        content: Text(
          'Оплаченный период членства в автоклубе Cadillac заканчивается через $difference $days! \nОбратитесь к администатору клуба!'.toUpperCase(),
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
                    'Написать'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: styleTextAlertDialog,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RenewAccount()));
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
                    'Закрыть'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: styleTextAlertDialog,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Account()));
                  },
                )
              ]))
        ],
      );
    },
  );
}
