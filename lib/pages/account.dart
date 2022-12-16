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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cadillac/models/users.dart' as my_user;
import 'package:cadillac/pages/data.dart';
import 'package:cadillac/pages/editAccount.dart';
import 'package:cadillac/pages/gift.dart';

import '../services/auth.dart';
import 'entrance.dart';

//class Account extends StatelessWidget {
class Account extends StatefulWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // late dynamic userId='5gOD8E3TlCfnjTW1Aso1VvjiG9C3';
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
  dynamic currentUser;

  late String platform;
  late Color colorCard;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    debugPrint('user account');
    final String? uid = user?.uid;
    debugPrint(uid);
    debugPrint(user?.email);
    // debugPrint(Provider
    //     .of<Data>(context, listen: false)
    //     .data['counter'].toString());

    //userId = Provider.of<Data>(context, listen: false).data['userId'].toString();
    //debugPrint(userId);
    //platform = Provider.of<Data>(context).data['platform'].toString();
    //debugPrint(platform);

    // List<Cookie> cookies = [Cookie("uuid", "$userId")];
    //
    // var dio = Dio();
    // var cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));
    //
    // //Save cookies
    // cookieJar.saveFromResponse(Uri.parse(baseUrl), cookies);
    //
    // var response = getCookie();
    // debugPrint('cookies account');
    //debugPrint(response); error

    currentUser = getUser(uid, context);

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
                  onPressed: () async{
                    //AuthService().logOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) =>
                            Entrance()
                    ));
                  },
                  icon: const Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
                  )
            ],
          ),
          // body: Consumer<Data>(builder: (context, data, child) {
    body: FutureBuilder<my_user.User> (
            //return FutureBuilder<User>(
                future: currentUser,
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

                    var status = snapshot.data?.status;

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

                    switch (snapshot.data?.status) {
                      case 'LUXURY':
                       colorCard = Color(0xFFFFFFFF);
                        break;
                      case 'PREMIUM':
                        colorCard = Color(0xFFFFBF00);
                        break;
                      case 'PLATINUM':
                        colorCard = Color(0xFFC0C0C0);
                        break;
                      default:
                        colorCard = Colors.transparent;
                    }

                    return Center(
                        child: SizedBox(
                            width: 284,
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Column(children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: TitlePage(title: 'мой аккаунт члена\nавтоклуба'),
                                ),
                                Container(
                                    width: 284,
                                    // height: 100,
                                    margin: const EdgeInsets.only(top: 43.0, bottom: 43.0),
                                    color: Colors.transparent,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 36,
                                                    margin: const EdgeInsets.only(
                                                      right: 28.0,
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      height: 22.0,
                                                      width: 19.06,
                                                      color: Colors.transparent,
                                                      child: SvgPicture.asset('assets/images/account.svg', semanticsLabel: 'Icon author')),
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Text('${snapshot.data?.username}'.toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: 'CadillacSans',
                                                          color: Colors.white,
                                                          height: 1.4, //line-height : font-size
                                                        )),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 36,
                                                    margin: const EdgeInsets.only(
                                                      right: 28.0,
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                    child: const Icon(Icons.work_outline_outlined, size: 22, color: Colors.white),
                                                    // child: SvgPicture.asset('assets/images/account.svg', semanticsLabel: 'Icon author', height: 22.0),
                                                  ),
                                                  Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text('${snapshot.data?.fieldOfActivity}'.toUpperCase(),
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.normal,
                                                            fontFamily: 'CadillacSans',
                                                            color: Colors.white,
                                                            height: 1.4, //line-height : font-size
                                                          )))
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
                                                      margin: const EdgeInsets.only(
                                                        right: 28.0,
                                                      ),
                                                      alignment: Alignment.topLeft,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Route route = MaterialPageRoute(builder: (context) => Edit());
                                                      Navigator.push(context, route);
                                                    },
                                                    onLongPress: () {
                                                      Route route = MaterialPageRoute(builder: (context) => Edit());
                                                      Navigator.push(context, route);
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/images/edit.svg',
                                                      semanticsLabel: 'Icon edit',
                                                      height: 22.0,
                                                      color: const Color(0xFF515569),
                                                    ),
                                                    // onPressed: () {
                                                    //   Route route = MaterialPageRoute(builder: (context) => Edit());
                                                    //   Navigator.push(context, route);
                                                    // },
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
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: ClipOval(
                                          child: CircleAvatar(
                                              radius: 48,
                                              backgroundColor: Colors.transparent,
                                              child: (snapshot.data?.path != null && snapshot.data?.path != '')
                                                  ? Image.memory(base64.decode(snapshot.data?.path ?? ''), fit: BoxFit.cover, width: 96, height: 96)
                                                  : Image.asset(
                                                'assets/images/no-image.jpg',
                                                fit: BoxFit.cover, width: 96, height: 96),
                                        )),
                                      ),
                                    ])),
                                Text('моя карта привилегий'.toUpperCase(),
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
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorCard,
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(top: 10, bottom: 25),
                                  child: status != 'без статуса' ? Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text('${snapshot.data?.status}'.toString().toUpperCase(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontFamily: 'CadillacSans',
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('номер карты ${snapshot.data?.numberCard}'.toString().toUpperCase(),
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.black,
                                                  )),
                                              Text('id ${snapshot.data?.id}'.toString().padLeft(4, '0').toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'CadillacSans',
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ),

                                      ]
                                  )
                                  : Container(
                                    child: Text('отсутствует'.toString().toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'CadillacSans',
                                              color: Colors.white,
                                            )),


                                  ),
                                ),

                                Text('мой автомобиль'.toUpperCase(),
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


                                ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    child: snapshot.data?.car1 == '' && snapshot.data?.car2 == '' && snapshot.data?.car3 == '' ?
                                    Image.asset(
                                  'assets/images/no-image.jpg',
                                  fit: BoxFit.cover,
                                    width: 284,
                                    height: 160,
                                ) : null,),


                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 160,
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(top: 10, bottom: 30, left: 0, right: 0),
                                  color: const Color(0xFF181C33),
                                  child: images.length == 1 ?
                                      Container(
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
                                              )
                                          ))

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
                                                  DotSwiperPaginationBuilder(color: Colors.white, activeColor: Color(0xFF8F97BF), size: 7.0, activeSize: 7.0)))),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Text('номер машины:'.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'CadillacSans',
                                                color: Colors.white,
                                                height: 1.5, //line-height : font-size
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text('${snapshot.data?.numberCar}' .toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'CadillacSans',
                                                  color: Colors.white,
                                                  height: 1.7, //line-height / font-size
                                                )),
                                          )

                                        ]),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Text('год выпуска:'.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'CadillacSans',
                                                color: Colors.white,
                                                height: 1.5, //line-height : font-size
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text('${snapshot.data?.yearIssue}' .toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'CadillacSans',
                                                  color: Colors.white,
                                                  height: 1.7, //line-height / font-size
                                                )),
                                          )

                                        ]),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                ]),
                              ))
                            ])));
                  }
                  return const Center(child: Text('no data'));
                }),


          drawer: const NavDrawer(),
        ));
  }
}

Future<my_user.User> getUser(userId, context) async {
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
    debugPrint(response.body);
    checkAccount(my_user.User.fromJson(userJson).dateExpired, context);

    var data = my_user.User.fromJson(userJson);
    debugPrint(data.numberCard);

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
        // title: Text('Подтвердите мой заказ'),
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
