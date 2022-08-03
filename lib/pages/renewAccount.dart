import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/pages/account.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:cadillac/models/partners.dart';

class RenewAccount extends StatefulWidget {
  const RenewAccount({Key? key}) : super(key: key);

  get partners => null;

  @override
  State<RenewAccount> createState() => _RenewAccountState();
}

class _RenewAccountState extends State<RenewAccount> {
  int selectedIndex = 1;
  final _formKey = GlobalKey<FormBuilderState>();

  late dynamic email = 'test@test';
  late dynamic subject = '5555';
  late dynamic theme = 'Заказ атрибутики';
  late dynamic message = 'message';

  late Future<PartnersList> partnersList;
  late String partnerId;
  late String path = "assets/images/avatar.png";

  @override
  void initState() {
    super.initState();
    partnersList = getPartnersList();
  }

  bool isLoadedImage = false;
  late String currentPartnerId;

  @override
  Widget build(BuildContext context) {
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
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
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
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(
                      width: 284,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const TitlePage(title: 'Продление аккаунта члена клуба Cadillac'),
                    ),
                    SizedBox(
                      width: 284,
                      child: FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                                initialValue: 'продление аккаунта',
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
                                  initialValue: "Продление аккаунта",
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    fillColor: Color(0XFF515569),
                                    filled: true,
                                    hintText: "Атрибутика",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onSaved: (value) => theme = value!,
                                  validator: FormBuilderValidators.compose([
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
                              margin: const EdgeInsets.only(top: 17, bottom: 10),
                              child: Text(
                                'сообщение'.toUpperCase(),
                                textAlign: TextAlign.left,
                                style: styleTitleFormInput,
                              ),
                            ),
                            FormBuilderTextField(
                              name: 'message',
                              initialValue:
                                  "У меня заканчивается оплаченный период членства в автоклубе Cadillac, прошу выписать счет на оплату следующего периода",
                              style: styleFormInput,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                fillColor: Color(0XFF515569),
                                filled: true,
                                hintText: "Введите ваше сообщение",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onSaved: (value) => message = value!,
                              validator: FormBuilderValidators.compose([
                                (val) {
                                  if (val == null) {
                                    return 'Поле message не может быть пустым';
                                  } else if (val.length < 5) {
                                    return 'Минимум 5 символа';
                                  } else {
                                    return null;
                                  }
                                },
                              ]),
                              minLines: 6, // any number you need (It works as the rows for the textarea)
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
                        child: Text(
                          "отправить".toUpperCase(),
                          style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          confirmDialog(context);
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            debugPrint('Message send');
                            final order = Order(
                              email: email,
                              subject: subject,
                              theme: theme,
                              message: message,
                            );
                            send(order);
                          } else {
                            debugPrint('Error');
                          }
                        },
                      ),
                    ),
                  ]))),
                ]),
          ),
          drawer: const NavDrawer(),
        ));
  }

  send(Order order) async {
    dynamic email = order.email;
    dynamic subject = order.subject;
    dynamic theme = order.theme;
    dynamic message = order.message;

    String apiUrl = baseUrl + "/test/mail.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
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
      debugPrint('email send');

      debugPrint(response.body);
      return response.body;
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
        content: Text(
          'Отправить заявку?'.toUpperCase(),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Account()));
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

Future<PartnersList> getPartnersList() async {
  debugPrint('getPartnersList');
  const url = baseUrl + '/test/partners_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return PartnersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
