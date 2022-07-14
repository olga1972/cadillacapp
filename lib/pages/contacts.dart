// import 'dart:html';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/pages/account.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
//import 'package:cadillac/widgets/partnersList.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:cadillac/models/partners.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  get partners => null;

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  int selectedIndex = 1;
  final _formKey = GlobalKey<FormBuilderState>();

  // get currentUser => null;

  late dynamic email = 'test@test';
  late dynamic subject = '5555';
  late dynamic theme = 'Заказ атрибутики';
  late dynamic message = 'message';

  late Future<PartnersList> partnersList;

  //late Future<Partner> partners;
  late String partnerId;


  late String path = "assets/images/avatar.png";
  // late List<dynamic> partnerImage;
  //late Future<New> deleteNews;

  @override
  void initState() {
    super.initState();
    partnersList = getPartnersList();

  }

  bool isLoadedImage = false;
  late File _image;
  late String currentPartnerId;


  // final styleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  // );

  // final styleTitleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  //   height: 1.5, //line-height : font-size
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
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
                  // tooltip:
                  //     MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                //ListView(
                children: [
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(top: 10, bottom: 47),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const TitlePage(title: 'мы в соцсетях'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 80),
                          child: const Socials(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text('есть вопрос?'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: styleTitleFormInput),
                        ),
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const TitlePage(title: 'напишите нам'),
                        ),
                        SizedBox(
                          width: 284,
                          child: FormBuilder(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Visibility(
                                      visible: false,
                                      child: FormBuilderTextField(
                                        name: 'email',
                                        initialValue: 'olga.sadyreva@mail.ru',
                                        onSaved: (value) => email = value!,
                                      ),
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: FormBuilderTextField(
                                        name: 'subject',
                                        initialValue: 'заказ атрибутики',
                                        onSaved: (value) => subject = value!,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'тема'.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: styleTitleFormInput,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 284,
                                      child: FormBuilderTextField(
                                          name: 'theme',
                                          style: styleFormInput,
                                          initialValue: "Атрибутика",
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(16),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            fillColor: Color(0XFF515569),
                                            filled: true,
                                            hintText: "Атрибутика",
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          // onChanged: _onChanged,
                                          onSaved: (value) => theme = value!,
                                          // valueTransformer: (text) => num.tryParse(text),
                                          // validator: FormBuilderValidators.compose([
                                          //   // FormBuilderValidators.required(context),
                                          //   // FormBuilderValidators.numeric(context),
                                          //   // FormBuilderValidators.max(context, 70),
                                          // ]),
                                          validator:
                                              FormBuilderValidators.compose([
                                            (val) {
                                              if (val == null) {
                                                return 'Поле theme не может быть пустым';
                                              } else if (val.length < 3) {
                                                return 'Минимум 3 символа';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ]),
                                          keyboardType: TextInputType.text),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 17, bottom: 10),
                                      child: Text(
                                        'сообщение'.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: styleTitleFormInput,
                                      ),
                                    ),
                                    FormBuilderTextField(
                                      name: 'message',
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите ваше сообщение",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      // onChanged: _onChanged,
                                      onSaved: (value) => message = value!,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   // FormBuilderValidators.required(context),
                                      //   // FormBuilderValidators.numeric(context),
                                      //   // FormBuilderValidators.max(context, 70),
                                      // ]),
                                      validator: FormBuilderValidators.compose([
                                        (val) {
                                          if (val == null) {
                                            return 'Поле message не может быть пустым';
                                          } else if (val.length < 5) {
                                            // return 'Invalid email address';
                                            return 'Минимум 5 символа';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ]),
                                      minLines:
                                          6, // any number you need (It works as the rows for the textarea)
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ])),
                        ),
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(top: 30, bottom: 45),
                          child: MaterialButton(
                            padding: const EdgeInsets.all(17),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            // textColor: const Color(0xFF12141F),
                            child: Text(
                              "отправить".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xFF12141F)),
                            ),

                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              confirmDialog(context);
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                debugPrint('Message send');
                                final order = Order(
                                  email: email,
                                  subject: subject,
                                  theme: theme,
                                  message: message,
                                );
                                send(order);

                                // Navigator
                                //     .pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (
                                //             context) =>
                                //             Account()
                                //     ));
                              } else {
                                debugPrint('Error');
                              }
                            },
                          ),
                        ),
                        Container(
                          child: Container(
                            // width: MediaQuery.of(context).size.width,
                            width: 284,
                            height: 114,
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(
                                top: 50, bottom: 0, left: 0,right: 0),
                            color: const Color(0xFF181C33),
                              child: FutureBuilder<PartnersList>(
                                  future: partnersList,
                                  builder: (context, snapshot) {

                                    var partners = snapshot.data?.partners;
                                    List<Partner>? partnersList = snapshot.data?.partners;
                                    print('partners');
                                    print(partnersList);

                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(snapshot.error.toString()));
                                    }

                                    if (snapshot.hasData) {
                                      int countImages = snapshot.data
                                          !.partners.length;
                                      return Swiper(
                                        // containerHeight: 92,
                                        containerWidth: 284,
                                        // layout: SwiperLayout.CUSTOM,
                                        // customLayoutOption:
                                        // CustomLayoutOption(startIndex: -1, stateCount: 2)
                                        //   ..addTranslate([
                                        //     const Offset(-28.0, 0.0),
                                        //     const Offset(256.0, 0.0),
                                        //     // const Offset(304.0, 0.0)
                                        //   ]),

                                        viewportFraction: 1,
                                        itemHeight: 114,
                                        itemWidth: 284,
                                        autoplay: true,
                                        itemCount: countImages,
                                        // outer: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          late Uint8List bytes;

                                          var pathEncode = snapshot.data?.partners[index].path;
                                          var decode64 = base64.decode(pathEncode!);

                                          bytes = decode64;


                                          if (snapshot.data?.partners[index].path != null) {
                                            isLoadedImage = true;

                                          } else {
                                            isLoadedImage = false;
                                          }
                                          return Container (
                                              width: 284,
                                              height: 160,
                                              decoration: const BoxDecoration(
                                                color: Color(0XffE4E6FF),
                                                borderRadius: BorderRadius.all(Radius
                                                    .circular(20.0)),
                                              ),
                                              margin: const EdgeInsets.only(bottom: 10.0, top: 10, left: 10,right: 10),
                                              child: isLoadedImage ?
                                              ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  child: Image.memory(base64.decode(snapshot.data?.partners[index].path ?? ''), fit: BoxFit.cover, width: 284, height: 107)) :
                                              const Text('no image',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Color(0xFF8F97BF),
                                                    height: 1.7, //line-height / font-size
                                                  ))
                                          );
                                        },
                                        // control: SwiperControl(),
                                      );
                                    }

                                    return const Center(child: Text('no data'));
                                  }
                              )
                          ),
                        )
                      ]))),
                ]),
          ),

          // body: Center (
          //   child: Container (
          //   width: 284,
          //
          //     child: Column (
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container (
          //           margin: const EdgeInsets.only(bottom: 5),
          //           child: const TitlePage(title: 'мы в соцсетях'),
          //         ),
          //
          //         Container (
          //           margin: const EdgeInsets.only(bottom: 80),
          //           child: Socials(),
          //         ),
          //
          //         Container (
          //           margin: const EdgeInsets.only(bottom: 15),
          //           child: Text('есть вопрос?'.toUpperCase(),
          //               textAlign: TextAlign.center,
          //               style: styleTitleFormInput
          //           ),
          //         ),
          //         Container (
          //           margin: const EdgeInsets.only(bottom: 30),
          //           child: const TitlePage(title: 'напишите нам'),
          //         ),
          //

          //       ]
          //     )
          //   ),
          // ),
          drawer: const NavDrawer(),
        ));
  }

  send(Order order) async {
    dynamic email = order.email;
    dynamic subject = order.subject;
    dynamic theme = order.theme;
    dynamic message = order.message;

    // String apiurl = "http://localhost/test/mail.php";
    String apiurl = baseUrl + "/test/mail.php";

    var response = await http.post(Uri.parse(apiurl), body: {
      'email': email,
      'subject': subject,
      'theme': theme,
      'message': message
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('email send');
      // var uuid = const Uuid();
      // id = uuid.v1();
      print(response.body);
      return response.body;
      // return User.fromJson(jsonDecode(response.body));
      // setState(() {
      //   showprogress = false; //don't show progress indicator
      //   error = true;
      //   errormsg = jsondata["message"];
      // });

    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}

class Order {
  late final String email;
  late final String subject;
  late final String theme;
  late final String message;

  Order({
    required this.email,
    required this.subject,
    required this.theme,
    required this.message,
  });
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Заказать атрибутику?'.toUpperCase(),
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

void _onChanged() {}

Future<PartnersList> getPartnersList() async {
  print('getPartnersList');
  const url = baseUrl + '/test/partners_list.php';
  final response = await http.get(Uri.parse(url));
  print('response getPartnersList');
  print(response.body);
  if(response.statusCode == 200) {
    return PartnersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}