// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/socials.dart';
import 'package:cadillac/widgets/partnersList.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  // get currentUser => null;

  late dynamic email = 'test@test';
  late dynamic subject = '5555';
  late dynamic theme = 'Заказ атрибутики';
  late dynamic message = 'message';


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
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset('assets/images/burger.svg'),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),

          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //ListView(
                children: [
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 47),
                  ),
                  Expanded(
                      child: SingleChildScrollView(

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: [
                                Container(
                                  width: 284,
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: const TitlePage(
                                      title: 'мы в соцсетях'),
                                ),

                              Container (
                                margin: const EdgeInsets.only(bottom: 80),
                                child: Socials(),
                              ),
                              Container (
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Text('есть вопрос?'.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: styleTitleFormInput
                                ),
                              ),
                              Container (
                                width: 284,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: const TitlePage(title: 'напишите нам'),
                              ),
                              Container (
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
                                                child:
                                                FormBuilderTextField(
                                                  name: 'email',
                                                  initialValue: 'olga.sadyreva@mail.ru',
                                                  onSaved: (value) => email = value!,
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child:
                                                FormBuilderTextField(
                                                  name: 'subject',
                                                  initialValue: 'заказ атрибутики',
                                                  onSaved: (value) => subject = value!,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 10),
                                                child: Text('тема'.toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: styleTitleFormInput,
                                                ),
                                              ),
                                              Container(
                                                width: 284,
                                                child:        FormBuilderTextField(
                                                    name: 'theme',
                                                    style: styleFormInput,
                                                    initialValue: "Атрибутика",
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.all(16),
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                                      ),

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
                                                    keyboardType: TextInputType.text
                                                ),
                                              ),



                                              Container(
                                                margin: const EdgeInsets.only(top: 17, bottom: 10),
                                                child: Text('сообщение'.toUpperCase(),
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
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),

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
                                                minLines: 6, // any number you need (It works as the rows for the textarea)
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                              ),
                                            ]
                                        )
                                    ),
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
                                    style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                  ),

                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.all(Radius.circular(10),
                                      ),
                                  ),
                                  onPressed: () {
                                    confirmDialog(context);
                                    if (_formKey.currentState?.saveAndValidate() ??false) {
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
                                Container (
                                  child: Container (
                                    // width: MediaQuery.of(context).size.width,
                                    width: 284,
                                    height: 200,
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.only(top: 50, bottom: 0, left: 0, right: 0),
                                    color: Color(0xFF181C33),
                                    child: PartnersList(),
                                  ),
                                )



                              ]
                          )
                      )
                  ),


                ]
            ),

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
            drawer: NavDrawer(),
          )
    );
  }

  send(Order order) async {
    dynamic email = order.email;
    dynamic subject = order.subject;
    dynamic theme = order.theme;
    dynamic message = order.message;

    // String apiurl = "http://localhost/test/mail.php";
    String apiurl = baseUrl + "/test/mail.php";

    var response = await http.post(Uri.parse(apiurl),body:{'email': email, 'subject':subject,'theme': theme, 'message': message},headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});

    if(response.statusCode == 200){
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
        title: Text('Подтвердите ваш заказ'),
        content: Text('Хочу заказать атрибутику'),
        actions: <Widget>[
          MaterialButton(
            child: Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            child: Text('Ок'),
            onPressed: () {
              Navigator
                  .pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (
                          context) =>
                          Account()
                  ));
            },
          )
        ],
      );
    },
  );
}

void _onChanged() {
}