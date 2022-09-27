import 'package:cadillac/pages/entrance.dart';
import 'package:cadillac/pages/registrationAdmin.dart';
import 'package:cadillac/pages/success-payment.dart';
import 'package:flutter/material.dart';

import 'package:cadillac/pages/data.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:cadillac/variables.dart';

import 'package:cadillac/pages/account.dart';


import 'package:cadillac/models/users.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:cadillac/pages/accountAdmin.dart';

import 'auth.dart';

var uuid = '1';
late bool isAuth;

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key, }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      uuid = '1';
      isAuth = false;
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();

  late dynamic userId;
  late dynamic login;
  late dynamic username = 'user';
  late dynamic email = ' test@test';
  late dynamic phone = '11111';
  final dynamic password = '123';
  final dynamic birthday = '111';
  late dynamic carname = 'carname';
  late dynamic path = 'path';
  late dynamic car1 = 'car1';
  late dynamic car2 = 'car2';
  late dynamic car3 = 'car3';

  late dynamic userIdFromProvider;
  
  late String cookie;

  late String platform;
  late String isAdmin;
  late String isShowConfirmRegister;

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  dynamic currentUser;
  dynamic newUser;
  dynamic user;

  final Uri url1 = Uri.parse('https://cadillacapp.ru/test/download.php');
  final Uri url2 = Uri.parse('https://cadillacapp.ru/test/download2.php');
  final Uri url3 = Uri.parse('https://cadillacapp.ru/terms_of_use.pdf');

  @override
  Widget build(BuildContext context) {
    debugPrint('registr page');

    // var cookies = getCookie();
    
    // isShowConfirmRegister = Provider
    //     .of<Data>(context)
    //     .data['isShowConfirmRegister'].toString();
    // isAdmin = Provider
    //     .of<Data>(context)
    //     .data['isAdmin'].toString();
    // counter = Provider
    //     .of<Data>(context, listen: false)
    //     .data['counter'].toString();

    isShowConfirmRegister = 'false';
    isAdmin = 'false';
    //counter = '1';

    // platform = Provider
    //     .of<Data>(context, listen: false)
    //     .data['platform'].toString();

    // print(isShowConfirmRegister);
    // print(isAdmin);
    // print(counter);
    // print(platform);

    // if(counter == '3') {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder:
    //               (context) =>
    //               const Account()));
    //
    // }

    // admin переход на успешная регистрация пользоавтеля, далее в аккоунт - ошибка!
    
      //
      //
      // userIdFromProvider = Provider
      //     .of<Data>(context, listen: false)
      //     .data['userId'].toString();
      // debugPrint(Provider
      //     .of<Data>(context, listen: false)
      //     .data['userId'].toString());


      return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
          title: 'Клуб Любителей Кадиллак в России',
          debugShowCheckedModeBanner: false,

          home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF181c33),
              shadowColor: Colors.transparent,
              elevation: 0.0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    padding: EdgeInsets.only(top: 15.0),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (context) =>
                              AuthorizationPage()));
                    },
                  );
                },
              ),

            ),
            body: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                                    children: [
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(bottom: 10,
                                            top: 0),
                                          child: Image.asset(
                                            'assets/images/logo_white.png',
                                            fit: BoxFit.fill,
                                            //height: 103.0,
                                          )

                                      ),

                                    ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width, height: 250),
                                        child: Center(
                                          child:  Container(
                                            width: 284,
                                            child: FormBuilder(
                                            key: _formKey,
                                            autovalidateMode: AutovalidateMode
                                                .always,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 284,
                                                    margin: const EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                      'ваш email'.toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: styleTitleFormInput,
                                                    ),
                                                  ),

                                                  FormBuilderTextField(
                                                      name: 'email',
                                                      autofocus: true,
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors.white,
                                                      style: styleFormInput,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets
                                                            .all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                        hintText: "Введите ваш email",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),

                                                      valueTransformer: (text) =>
                                                          num.tryParse(text!),
                                                      autovalidateMode: AutovalidateMode
                                                          .always,
                                                      controller: _emailController,
                                                      onSaved: (value) =>
                                                      email = value!,

                                                      validator: FormBuilderValidators
                                                          .compose([
                                                            (val) {
                                                          if (val == '') {
                                                            return 'Поле email не может быть пустым';
                                                          } else if (!_emailController.text
                                                              .contains('@')) {
                                                            // return 'Invalid email address';
                                                            return 'Неверный email адрес';
                                                          } else {
                                                            return null;
                                                          }
                                                        }
                                                      ]),
                                                      keyboardType: TextInputType
                                                          .emailAddress
                                                  ),

                                                  Container(
                                                    width: 284,
                                                    margin: const EdgeInsets.only(
                                                        top: 10, bottom: 10),
                                                    child: Text('ваш номер телефона'
                                                        .toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: styleTitleFormInput,
                                                    ),
                                                  ),

                                                  FormBuilderTextField(
                                                      name: 'phone',
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors.white,
                                                      style: styleFormInput,
                                                      inputFormatters: [
                                                        maskFormatterPhone
                                                      ],
                                                      autovalidateMode: AutovalidateMode
                                                          .always,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets
                                                            .all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                        hintText: "+7 ___-___-__-__",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),

                                                      validator: FormBuilderValidators
                                                          .compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return 'Поле phone не может быть пустым';
                                                          } else {
                                                            return null;
                                                          }
                                                        }
                                                      ]),
                                                      onSaved: (value) =>
                                                      phone = value!,
                                                      keyboardType: TextInputType
                                                          .phone
                                                  ),
                                                ]
                                            )
                                            ),
                                          )
                                        )
                                      ),
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(top: 30,
                                            bottom: 45),
                                        child: MaterialButton(
                                          height: 60,
                                          padding: const EdgeInsets.all(17),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          child: Text('отправить заявку'.toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF12141F),
                                                      height: 1.14),
                                              textAlign: TextAlign.center
                                              ),

                                          // child: Text.rich(
                                          //
                                          //   TextSpan(
                                          //       text: 'отправить заявку/'.toUpperCase(),
                                          //       style: const TextStyle(
                                          //           fontSize: 14,
                                          //           fontWeight: FontWeight.w500,
                                          //           color: Color(0xFF12141F),
                                          //           height: 1.14),
                                          //
                                          //       children: <InlineSpan>[
                                          //         TextSpan(
                                          //           text: 'администратору автоклуба'
                                          //               .toUpperCase(),
                                          //           style: const TextStyle(
                                          //               fontSize: 14,
                                          //               fontWeight: FontWeight
                                          //                   .normal,
                                          //               color: Color(0xFF12141F),
                                          //               height: 1.14),
                                          //         )
                                          //       ]
                                          //   ),
                                          // ),

                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState?.validate() == false) {
                                              debugPrint('Invalid');
                                              _errorMessage(context);
                                            } else {
                                            if (_formKey.currentState
                                              ?.saveAndValidate() ?? false) {
                                                debugPrint('valid');
                                              // Navigator.pushReplacement(
                                              //     context, MaterialPageRoute(
                                              //     builder: (context) =>
                                              //     const RegistrationAdmin()
                                              // ));
                                              // debugPrint('email');
                                              // debugPrint(email);

                                            if (email == emailAdmin) {
                                              debugPrint('admin');
                                              Navigator.pushReplacement(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                              const RegistrationAdmin()
                                              ));
                                            } else {
                                              debugPrint('user');
                                              final request = Request(
                                                email: email,
                                                phone: phone,
                                                theme: 'Запрос на регистрацию',
                                                message: 'Хочу зарегистрироваться в приложении Cadillac',
                                              );
                                              confirmDialog(context, request);

                                              }


                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.only(top: 0, bottom: 30),
                                      //   child: GestureDetector(
                                      //     onTap: getTermsOfUse(url3),
                                      //     child: const Text.rich(
                                      //       TextSpan(
                                      //           text: 'Продолжая вы принимаете ',
                                      //           style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF8F97BF), height: 1.5),
                                      //           children: <InlineSpan>[
                                      //             TextSpan(
                                      //               text: 'Пользовательское соглашение и конфиденциальность',
                                      //               style: TextStyle(
                                      //                 decoration: TextDecoration.underline,
                                      //                 decorationThickness: 2,
                                      //               ),
                                      //             )
                                      //           ]),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10,
                                            bottom: 10),
                                        child: Text('Скачать'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),

                                      Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MaterialButton(
                                                padding: const EdgeInsets.all(17),
                                                child: Image.asset(
                                                  'assets/images/app1.png',
                                                  fit: BoxFit.contain,
                                                  height: 58,
                                                ),
                                                onPressed: () {
                                                  launchURL(url1);
                                                }),

                                            MaterialButton(
                                              padding: const EdgeInsets.all(17),
                                              child: Image.asset(
                                                'assets/images/app2.png',
                                                fit: BoxFit.contain,
                                                height: 58,
                                              ),
                                              onPressed: () {
                                                launchURL(url2);
                                              },
                                            ),

                                          ]
                                      ),
                                    ]
                                )
                            )
                        )
                      ]
                  )
              ),
            ),
          )
      );
    }

    Future confirmDialog(BuildContext context, request) async {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Отправить заявку?'.toUpperCase(),
              textAlign: TextAlign.center,
              style: styleTextAlertDialog,
            ),
            actions: <Widget>[
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
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
                            onPressed: () async{
                              debugPrint('onpresssed');
                              send(request);
                                    await Navigator.pushReplacement(
                                        context, MaterialPageRoute(
                                        builder: (context) =>
                                            Entrance()
                                    ));

                              _formKey.currentState?.save();
                              debugPrint(
                                  'Request for registration send');
                            }
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
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                builder: (context) =>
                                    RegistrationPage()
                            ));
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

    Future _errorMessage(BuildContext context) async {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Все поля формы обязательны для заполнения'.toUpperCase(),
              textAlign: TextAlign.center,
              style: styleTextAlertDialog,
            ),
            actions: <Widget>[
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                              'Закрыть'.toUpperCase(),
                              textAlign: TextAlign.right,
                              style: styleTextAlertDialog,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            }
                        ),
                      ]
                  )
              )
            ],
          );
        },
      );
    }



    // Future getUser(userId) async {
    //   debugPrint('userId: $userId');
    //
    //   String apiUrl = baseUrl + "/test/get_user.php";
    //
    //   final response = await http.post(
    //       Uri.parse(apiUrl), body: {'userId': userId},
    //       headers: {
    //         'Accept': 'application/json, charset=utf-8',
    //         "Access-Control-Allow-Origin": "http://localhost:59369",
    //         "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    //       });
    //   if (response.statusCode == 200) {
    //     debugPrint(response.statusCode.toString());
    //     debugPrint(response.body);
    //
    //     final userJson = json.decode(response.body);
    //     var data = User.fromJson(userJson);
    //     Provider.of<Data>(context, listen: false).updateUserId(data.userId);
    //     return (data);
    //   } else {
    //     throw Exception('Error fetching users');
    //   }
    // }

    Future send(Request request) async {
    debugPrint('send');
      dynamic email = request.email;
      dynamic phone = request.phone;
      dynamic theme = request.theme;
      dynamic message = request.message;

      String apiUrl = baseUrl + "/test/mail_request.php";

      var response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'phone': phone,
        'theme': theme,
        'message': message
      }, headers: {
        'Accept': 'application/json, charset=utf-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
      });

      if (response.statusCode == 200) {
        debugPrint('email for registration send');
        debugPrint(response.body);
        return response.body;
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    }
}

class Request {
  late final String email;
  late final String phone;
  late final String theme;
  late final String message;

  Request({
    required this.email,
    required this.phone,
    required this.theme,
    required this.message,
  });
}

  // getCookie() async {
  //   debugPrint('get cookie');
  //   var dio =  Dio();
  //   var cookieJar=CookieJar();
  //   dio.interceptors.add(CookieManager(cookieJar));
  //
  //   // Get cookies
  //   // var cookies = cookieJar.loadForRequest(Uri.parse("https://cadillacapp.ru/"));
  //   //debugPrint(cookies);
  //   // second request with the cookie
  //   //debugPrint(dio.get("https://cadillacapp.ru/"));
  //
  //   var response = await dio.get("https://cadillacapp.ru/");
  //   //debugPrint(response);
  //
  //   return response;
  //     // List<Cookie> cookies = [
  //     //   new Cookie("uuid", "9265988f-e70d-11ec-af6a-00ff21c5bb0a"),
  //     //   // ....
  //     // ];
  //
  //     //Save cookies
  //     //cookieJar.saveFromResponse(Uri.parse("http://localhost"), cookies);
  //     //debugPrint(cookies);
  //     //await dio.get(baseUrl);
  // }

downLoadApp() async {
  debugPrint('download');
  String apiUrl = baseUrl + "/test/download.php";

  var response = await http.post(Uri.parse(apiUrl));

  if(response.statusCode == 200){
    debugPrint('success download');
    // debugPrint(response.statusCode.toString());
    return true;
  }else{
    debugPrint('error');
    throw Exception('We were not able to successfully download the json data.');
  }
}

void launchURL(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

// getTermsOfUse(url) async {
//   if (!await launchUrl(url)) throw 'Could not launch $url';
// }