// import 'dart:html';

import 'dart:typed_data';

import 'package:cadillac/pages/partnersAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cadillac/utils/generate_password.dart';

import 'package:cadillac/variables.dart';


import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../models/users.dart';
import 'data.dart';
import 'membersAdmin.dart';


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);


  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {


  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   //_passwordController.dispose();
  //   super.dispose();
  // }
  final newPassword = generatePassword();


  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  //final _passwordController = TextEditingController();
  //_passwordController.text = newPassword;


  late String id = '1';
  String userId = Uuid().v1();
  late dynamic email = ' dgferger';
  late dynamic phone = 'erterert';
  final dynamic birthday = '111';
  late dynamic carname = 'carname';
  late dynamic path = 'path';
  late dynamic car1 = 'car1';
  late dynamic car2 = 'car2';
  late dynamic car3 = 'car3';
  late dynamic password = '1111111111';

  late String platform;
  late String text;


  //late final password;
  dynamic currentUser;
  dynamic newUser;
  dynamic user;


  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

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
    platform = Provider
        .of<Data>(context)
        .data['platform'].toString();
    print(platform);
    print(newPassword);

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
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          //   elevation: 0.0,
          //   leading: Builder(
          //     builder: (BuildContext context) {
          //       return IconButton(
          //         icon: SvgPicture.asset('assets/images/burger.svg'),
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //         tooltip:
          //         MaterialLocalizations.of(context).openAppDrawerTooltip,
          //       );
          //     },
          //   ),
          // ),

          body: Center(
              child: Container(
                width: 284,
                margin: const EdgeInsets.only(top: 70),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(bottom: 40),
                                    child: const TitlePage(
                                        title: 'добавить нового члена клуба'),
                                  ),

                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        FormBuilder(
                                            key: _formKey,
                                            autovalidateMode: AutovalidateMode
                                                .always,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .only(
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
                                                      // decoration: ThemeHelper().textInputDecoration('', 'Введите ваш email', 'Введите ваш email'),
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets
                                                            .all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                        hintText: "Введите ваш email",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,

                                                      valueTransformer: (
                                                          text) =>
                                                          num.tryParse(text!),
                                                      autovalidateMode: AutovalidateMode
                                                          .always,
                                                      // validator: _validateEmail,
                                                      controller: _emailController,
                                                      onSaved: (value) =>
                                                      email = value!,
                                                      validator: FormBuilderValidators
                                                          .compose([
                                                        // FormBuilderValidators.required(context, errorText: 'Обязательное поле'),
                                                            (val) {
                                                          if (val == '') {
                                                            return 'Поле email не может быть пустым';
                                                          } else
                                                          if (!_emailController
                                                              .text
                                                              .contains('@')) {
                                                            // return 'Invalid email address';
                                                            return 'Неверный email адрес';
                                                          } else {
                                                            return null;
                                                          }
                                                        }

                                                        // FormBuilderValidators.max(context, 20),
                                                        // FormBuilderValidators.email(context),
                                                      ]),
                                                      keyboardType: TextInputType
                                                          .emailAddress
                                                  ),

                                                  Container(
                                                    margin: const EdgeInsets
                                                        .only(
                                                        top: 10, bottom: 10),
                                                    child: Text(
                                                      'ваш номер телефона'
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
                                                      // decoration: ThemeHelper().textInputDecoration('+7 ___-___-__-__', '', ''),
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
                                                                Radius.circular(
                                                                    10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                        hintText: "+7 ___-___-__-__",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,

                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: (value) => _validatePhoneNumber(value!)
                                                      //     ? null
                                                      //     : 'Phone number must be entered as (###)###-####',
                                                      controller: _phoneController,
                                                      validator: FormBuilderValidators
                                                          .compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return 'Поле phone не может быть пустым';
                                                            // } else if (!_emailController.text.contains('@')) {
                                                            //   // return 'Invalid email address';
                                                            //   return 'Неверный email адрес';
                                                          } else {
                                                            return null;
                                                          }
                                                        }
                                                        // FormBuilderValidators.required(context),
                                                        // FormBuilderValidators.numeric(context),
                                                        // FormBuilderValidators.max(context, 70),
                                                      ]),
                                                      onSaved: (value) =>
                                                      phone = value!,
                                                      keyboardType: TextInputType
                                                          .phone
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .only(
                                                        top: 10, bottom: 10),
                                                    child: Text('ваш пароль'
                                                        .toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: styleTitleFormInput,
                                                    ),
                                                  ),

                                                  FormBuilderTextField(
                                                      name: 'password',
                                                      //readOnly: true,
                                                      // enabled: false,
                                                      initialValue: newPassword,
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors.white,
                                                      style: styleFormInput,

                                                      // decoration: ThemeHelper().textInputDecoration('+7 ___-___-__-__', '', ''),
                                                      // autovalidateMode: AutovalidateMode
                                                      //     .always,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets
                                                            .all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                      ),
                                                      // onChanged: _onChanged,
                                                      //controller: _passwordController,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: (value) => _validatePhoneNumber(value!)
                                                      //     ? null
                                                      //     : 'Phone number must be entered as (###)###-####',

                                                      //validator: FormBuilderValidators

                                                      // FormBuilderValidators.required(context),
                                                      // FormBuilderValidators.numeric(context),
                                                      // FormBuilderValidators.max(context, 70),
                                                      //]),
                                                      //controller: _passwordController,
                                                      onSaved: (value) =>
                                                      password = value!,
                                                      keyboardType: TextInputType
                                                          .visiblePassword

                                                  ),
                                                  Container(
                                                      width: 284,
                                                      margin:
                                                      const EdgeInsets.only(
                                                          top: 30,
                                                          bottom: 45),
                                                      child: MaterialButton(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(17),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 255, 255, 255),
                                                        // textColor: const Color(0xFF12141F),
                                                        child: Text(
                                                          "добавить"
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF12141F)),
                                                        ),

                                                        shape:
                                                        const RoundedRectangleBorder(
                                                          side: BorderSide.none,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          print('onPressed');
                                                          debugPrint(_formKey
                                                              .currentState
                                                              ?.value
                                                              .toString());

                                                          if (_formKey
                                                              .currentState
                                                              ?.saveAndValidate() ??
                                                              false) {
                                                            debugPrint(
                                                                'Valid add user');

                                                            print(_formKey
                                                                .currentState
                                                                ?.fields);

                                                            print(userId);
                                                            //final user = User(email: email, phone :phone);
                                                            dynamic
                                                            currentUser =
                                                            User(
                                                                id: '1',
                                                                userId: userId,
                                                                phone: phone,
                                                                email: email,
                                                                username: 'username',
                                                                birthday: 'birthday',
                                                                login: email,
                                                                carname: 'carname',
                                                                path: 'path',
                                                                car1: 'car1',
                                                                car2: 'car2',
                                                                car3: 'car3',
                                                                password: password

                                                            );
                                                            //currentUser = editUser(user);
                                                            // editUser(
                                                            //     currentUser);

                                                            user =
                                                            await addUser(
                                                                currentUser);

                                                            final message = Message(
                                                              email: email,
                                                              phone: phone,
                                                              password: password,
                                                            );

                                                            sendMessageUser(message);


                                                            debugPrint(_formKey
                                                                .currentState
                                                                ?.value
                                                                .toString());

                                                            // debugPrint(box.get('phone2').toString());
                                                            Provider.of<Data>(
                                                                context,
                                                                listen: false)
                                                                .updateAccount(
                                                                1);

                                                            Navigator
                                                                .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (
                                                                        context) =>
                                                                        MembersAdmin()));
                                                            // Home());

                                                          } else {
                                                            debugPrint(
                                                                'Invalid');
                                                          }

                                                          // Navigator
                                                          //     .pushReplacement(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (
                                                          //             context) =>
                                                          //             Account())
                                                          // );
                                                        },
                                                      )),
                                                ]
                                            )

                                        )
                                      ]
                                  ),
                                ]
                            )
                        ),
                      ),
                    ]
                ),
              )
          ),
          drawer: const NavDrawerAdmin(),

        )
    );
  }

  addUser(User user) async {
    // var uuid = const Uuid();
    // var id = uuid.v1();
    print('func addUser registr');

    dynamic phone = user.phone;
    dynamic email = user.email;
    dynamic password = user.password;
    //dynamic path = user.path;
    //(path);
    dynamic userId = user.userId;


    String apiurl = baseUrl + "/test/create.php";
    //print(baseUrl + "/test/create.php");
    //String apiurl = "http://localhost/test/create.php";
    // var response = await http.post(Uri.parse(apiurl),body:{'userId': userId,'phone': phone,'email': email});
    var response = await http.post(Uri.parse(apiurl), headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    },
        body: {
          'userId': userId,
          'password': password,
          'phone': phone,
          'email': email
        });

    // final response = await http.post(Uri.parse(apiurl));
    //print(User.fromJson(jsonDecode(response.body)));

    if (response.statusCode == 200) {
      print('success add user');

      // print(Provider
      //     .of<Data>(context, listen: false)
      //     .data['userId'].toString());
      // print('userId: $userId');
      //Provider.of<Data>(context, listen: false).updateAccount(uuid);
      // var uuid = const Uuid();
      // var id = uuid.v1();
      print(response.statusCode);
      print(response.body);
      print(json.decode(response.body));
      final userJson = json.decode(response.body);

      dynamic data = User.fromJson(userJson);
      // return User.fromJson(userJson);
      return data;

      //return response.body; //это правильно
      //return User.fromJson(currentUser); // error
      //return User.fromJson(jsonDecode(response.body));
      // setState(() {
      //   showprogress = false; //don't show progress indicator
      //   error = true;
      //   errormsg = jsondata["message"];
      // });

    } else {
      print('error');
      throw Exception(
          'We were not able to successfully download the json data.');
    }
    //return response.body;
    //return User.fromJson(json.decode(response.body));
  }

  sendMessageUser(Message message) async {
    dynamic email = message.email;
    dynamic phone = message.phone;
    dynamic password = message.password;

    // String apiurl = "http://localhost/test/mail_request.php";
    String apiurl = baseUrl + "/test/message_user.php";

    var response = await http.post(Uri.parse(apiurl), body: {
      'email': email,
      'phone': phone,
      'password': password,

    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('email for registration send');
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

  Future confirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Подтвердите ваш заказ'),
          content: Text('Добавить пользователя'.toUpperCase(),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MembersAdmin()));
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

}

class Message {
  late final String email;
  late final String phone;
  late final String password;

  Message({
    required this.email,
    required this.phone,
    required this.password,
  });
}
