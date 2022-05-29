// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  get currentUser => null;

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
          ),

            body: Center (
              child: Container (
              width: 284,

                child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container (
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const TitlePage(title: 'мы в соцсетях'),
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
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const TitlePage(title: 'напишите нам'),
                    ),

                    FormBuilder(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                           Container(
                             margin: const EdgeInsets.only(bottom: 10),
                             child: Text('тема'.toUpperCase(),
                                 textAlign: TextAlign.left,
                                 style: styleTitleFormInput,
                             ),
                           ),

                              FormBuilderTextField(
                                name: 'theme',
                                style: styleFormInput,
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

                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  // FormBuilderValidators.required(context),
                                  // FormBuilderValidators.numeric(context),
                                  // FormBuilderValidators.max(context, 70),
                                ]),
                                keyboardType: TextInputType.text
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 17, bottom: 10),
                                child: Text('сообщение'.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: styleTitleFormInput,
                                ),
                              ),

                              FormBuilderTextField(
                                  name: 'theme',
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

                                  // valueTransformer: (text) => num.tryParse(text),
                                  validator: FormBuilderValidators.compose([
                                    // FormBuilderValidators.required(context),
                                    // FormBuilderValidators.numeric(context),
                                    // FormBuilderValidators.max(context, 70),
                                  ]),
                                  minLines: 6, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                              ),
                            ]
                        )
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
                          // _formKey.currentState.save();
                          // if (_formKey.currentState.validate()) {
                          //   print(_formKey.currentState.value);
                          // } else {
                          //   print("validation failed");
                          // }
                        },
                      ),
                    ),

                    Container (
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.only(top: 50, bottom: 0, left: 0, right: 0),
                      color: Color(0xFF181C33),
                      child: PartnersList(),
                    ),
                  ]
                )
              ),
            ),
            drawer: const NavDrawer(),
          )
    );
  }
}

void _onChanged() {
}