import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cadillac/utils/generate_password.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/widgets/titlePageAdmin.dart';

import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:async';

import 'package:cadillac/NavDrawerAdmin.dart';
import 'package:cadillac/models/users.dart' as my_user;
import 'package:cadillac/pages/data.dart';
import 'membersAdmin.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

  final newPassword = generatePassword();
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  late String id = '1';
  String userId = const Uuid().v1();
  late dynamic email = ' test@test';
  late dynamic phone = '1111111';
  final dynamic birthday = '111';
  late dynamic carname = 'carname';
  late dynamic path = 'path';
  late dynamic car1 = 'car1';
  late dynamic car2 = 'car2';
  late dynamic car3 = 'car3';
  late dynamic password = '1111111111';

  late String platform;
  late String text;
  late String dateRegister;
  late String dateNowRegister;
  late String dateExpired;
  late String dateYearExpired;
  late String numberCard;
  late String status;

  dynamic currentUser;
  dynamic newUser;
  // dynamic user;

  var maskFormatterPhone = MaskTextInputFormatter(mask: '+7 ___-___-__-__', filter: {"_": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {


    DateTime dateNowRegister = DateTime.now().toLocal();
    String timestampRegister =
        "${dateNowRegister.year.toString()}-${dateNowRegister.month.toString().padLeft(2, '0')}-${dateNowRegister.day.toString().padLeft(
        2, '0')} ${dateNowRegister.hour.toString().padLeft(2, '0')}:${dateNowRegister.minute.toString().padLeft(2, '0')}";

    DateTime dateYearExpired = DateTime(dateNowRegister.year + 1, dateNowRegister.month, dateNowRegister.day, dateNowRegister.hour, dateNowRegister.minute);
    String timestampExpired =
        "${dateYearExpired.year.toString()}-${dateYearExpired.month.toString().padLeft(2, '0')}-${dateYearExpired.day.toString().padLeft(
        2, '0')} ${dateYearExpired.hour.toString().padLeft(2, '0')}:${dateYearExpired.minute.toString().padLeft(2, '0')}";

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2C335E),
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
                    MembersAdmin()));
                  },
                );
              },
            ),

          ),
          body: Center(
              child: Container(
                width: 284,
                margin: const EdgeInsets.only(top: 35),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Container(
                            width: 284,
                            margin: const EdgeInsets.only(bottom: 40),
                            child: const TitlePageAdmin(title: 'добавить нового члена клуба'),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            FormBuilder(
                                key: _formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'email'.toUpperCase(),
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
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите email",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      valueTransformer: (text) => num.tryParse(text!),
                                      autovalidateMode: AutovalidateMode.always,
                                      controller: _emailController,
                                      onSaved: (value) => email = value!,
                                      validator: FormBuilderValidators.compose([
                                            (val) {
                                          if (val == '') {
                                            return 'Поле email не может быть пустым';
                                          } else if (!_emailController.text.contains('@')) {
                                            return 'Неверный email адрес';
                                          } else {
                                            return null;
                                          }
                                        }
                                      ]),
                                      keyboardType: TextInputType.emailAddress),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'номер телефона'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'phone',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      inputFormatters: [maskFormatterPhone],
                                      autovalidateMode: AutovalidateMode.always,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "+7 ___-___-__-__",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      controller: _phoneController,
                                      validator: FormBuilderValidators.compose([
                                            (val) {
                                          if (val == null) {
                                            return 'Поле phone не может быть пустым';
                                          } else {
                                            return null;
                                          }
                                        }
                                      ]),
                                      onSaved: (value) => phone = value!,
                                      keyboardType: TextInputType.phone),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'пароль'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'password',
                                      initialValue: newPassword,
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                      ),
                                      onSaved: (value) => password = value!,
                                      keyboardType: TextInputType.visiblePassword),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'статус'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  Container(
                                    width: 284.0,
                                    child: FormBuilderDropdown(
                                      name: 'status',
                                      elevation: 0,
                                      icon: SvgPicture.asset(
                                        'assets/images/caret-down-solid.svg',
                                        semanticsLabel: 'Icon dropdown',
                                        height: 16.0,
                                        width: 10.0,
                                        color: Colors.white,
                                      ),

                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'CadillacSans',
                                        color: Colors.white,

                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Выберите статус",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      dropdownColor: const Color(0XFF363b57),
                                      alignment: Alignment.bottomLeft,
                                      items: ['без статуса', 'LUXURY', 'PREMIUM', 'PLATINUM']
                                          .map((theme) => DropdownMenuItem(
                                        value: theme,
                                        child: Text(theme),
                                      )).toList(),
                                      onSaved: (value) => status = value.toString()!,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'номер карты'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'numberCard',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      autovalidateMode: AutovalidateMode.always,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "133 133 133",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      validator: FormBuilderValidators.compose([
                                            (val) {
                                          if (val == null) {
                                            return 'Поле number Card не может быть пустым';
                                          } else {
                                            return null;
                                          }
                                        }
                                      ]),
                                      onSaved: (value) => numberCard = value!,
                                      keyboardType: TextInputType.text),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'дата регистрации'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'dateRegister',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      initialValue: timestampRegister,
                                      autovalidateMode: AutovalidateMode.always,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                      ),
                                      validator: FormBuilderValidators.compose([
                                            (val) {
                                          return null;
                                        }
                                      ]),
                                      onSaved: (value) => dateRegister = value!,
                                      keyboardType: TextInputType.text),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'дата окончания'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'dateExpired',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      initialValue: timestampExpired,
                                      autovalidateMode: AutovalidateMode.always,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                      ),
                                      validator: FormBuilderValidators.compose([
                                            (val) {
                                          return null;
                                        }
                                      ]),
                                      onSaved: (value) => dateExpired = value!,
                                      keyboardType: TextInputType.text),
                                  Container(
                                      width: 284,
                                      margin: const EdgeInsets.only(top: 30, bottom: 45),
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(17),
                                        color: const Color.fromARGB(255, 255, 255, 255),
                                        child: Text(
                                          "добавить".toUpperCase(),
                                          style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {
                                          debugPrint('onPressed');
                                          // platform = Provider
                                          //     .of<Data>(context, listen: false)
                                          //     .data['platform'].toString();

                                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                                            debugPrint('Valid add user');
                                            // debugPrint(userId);

                                            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                                            User? user = FirebaseAuth.instance.currentUser;
                                            final String? uid = user?.uid;
                                            debugPrint(uid);
                                            debugPrint(user?.email);
                                            userId = uid!;

                                            dynamic currentUser = my_user.User(
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
                                              password: password,
                                              dateRegister: dateRegister,
                                              dateExpired: dateExpired,
                                              fieldOfActivity: 'fieldOfActivity',
                                              numberCar: 'numberCar',
                                              yearIssue: 'yearIssue',
                                              numberCard: numberCard,
                                              status: status,
                                            );

                                            newUser = await addUser(currentUser);
                                            await addUserToFirebase(currentUser);
                                            // await FirebaseAuth.instance.signOut();

                                            final message = Message(
                                              email: email,
                                              phone: phone,
                                              password: password,
                                            );

                                            sendMessageUser(message);
                                            debugPrint(_formKey.currentState?.value.toString());

                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MembersAdmin()));
                                          } else {
                                            debugPrint('Invalid');
                                          }
                                        },
                                      )),
                                ]))
                          ]),
                        ])),
                  ),
                ]),
              )),
          drawer: const NavDrawerAdmin(),
        ));
  }

  addUser(my_user.User user) async {
    debugPrint('func addUser registr');

    dynamic phone = user.phone;
    dynamic email = user.email;
    dynamic password = user.password;
    dynamic login = user.login;
    dynamic dateRegister = user.dateRegister;
    dynamic dateExpired = user.dateExpired;
    dynamic userId = user.userId;
    dynamic fieldOfActivity = user.fieldOfActivity;
    dynamic numberCar = user.numberCar;
    dynamic yearIssue = user.yearIssue;
    dynamic numberCard = user.numberCard;
    dynamic status = user.status;
    debugPrint('status');
    debugPrint(status);

    String apiUrl = baseUrl + "/test/create.php";

    var response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    }, body: {
      'userId': userId,
      'password': password,
      'phone': phone,
      'email': email,
      'login': login,
      'dateRegister': dateRegister,
      'dateExpired': dateExpired,
      'fieldOfActivity': fieldOfActivity,
      'numberCar': numberCar,
      'yearIssue': yearIssue,
      'numberCard': numberCard,
      'status': status,
    });
    if (response.statusCode == 200) {
      debugPrint('success add user');

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      final userJson = json.decode(response.body);

      dynamic data = my_user.User.fromJson(userJson);

      return data;
    } else {
      debugPrint('error');
      throw Exception('We were not able to successfully download the json data.');
    }
  }

  sendMessageUser(Message message) async {
    dynamic email = message.email;
    dynamic phone = message.phone;
    dynamic password = message.password;

    String apiUrl = baseUrl + "/test/message_user.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
      'email': email,
      'phone': phone,
      'password': password,
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

  Future confirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Добавить пользователя'.toUpperCase(),
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

  addUserToFirebase(my_user.User user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
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
