import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/models/users.dart';

import 'package:cadillac/pages/accountAdmin.dart';

import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import 'data.dart';

enum ImageSourceType { gallery, camera }

var uuid = '';

class RegistrationAdmin extends StatefulWidget {
  const RegistrationAdmin({
    Key? key,
  }) : super(key: key);

  final String path = '';

  @override
  State<RegistrationAdmin> createState() => _RegistrationAdminState();
}

class _RegistrationAdminState extends State<RegistrationAdmin> {
  late String encode64;

  dynamic user;
  dynamic findingUser;

  @override
  initState() {
    super.initState();
    uuid = '';
    encode64 = '';
  }

  final _formKey = GlobalKey<FormBuilderState>();

  late dynamic userId;
  late dynamic login = "test@mail.ru";
  late dynamic username;
  late dynamic email = 'test@test';
  late dynamic phone = '5555';
  late dynamic password;
  late dynamic birthday;
  late dynamic type;
  late dynamic carname;
  late String path = "assets/images/avatar.png";
  late String car1;
  late String car2;
  late String car3;

  late List<dynamic> photo;
  late List<dynamic> cars;

  late String platform;
  late Uint8List? bytes;
  late Uint8List? bytesCar1;
  late Uint8List? bytesCar2;
  late Uint8List? bytesCar3;

  var maskFormatterPhone = MaskTextInputFormatter(mask: '+7 ___-___-__-__', filter: {"_": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  var maskFormatterDate = MaskTextInputFormatter(mask: '__.__.____', filter: {"_": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    userId = Provider.of<Data>(context).data['userId'].toString();
    platform = Provider.of<Data>(context).data['platform'].toString();
    debugPrint(platform);
    debugPrint(userId);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 284,
                margin: const EdgeInsets.only(top: 10, bottom: 47),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                      width: 284,
                      margin: const EdgeInsets.only(bottom: 56),
                      child: FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                            Container(
                                width: 284,
                                margin: const EdgeInsets.only(top: 30, bottom: 10),
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 53, bottom: 40),
                                    child: const TitlePage(title: 'регистрация администратора \nавтоклуба cadillac'),
                                  ),
                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'ваш логин'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'login',
                                      autofocus: true,
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите ваш логин (email)",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      autovalidateMode: AutovalidateMode.always,
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (value) => login = value!),
                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваш пароль'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'password',
                                      cursorWidth: 1.0,
                                      autofocus: true,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите ваш password",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: FormBuilderValidators.compose([
                                        (val) {
                                          if (val == null) {
                                            return 'Поле password не может быть пустым';
                                          } else if (val.length < 10) {
                                            return 'Минимум 10 символов';
                                          } else {
                                            return null;
                                          }
                                        }
                                      ]),
                                      onSaved: (value) => password = value!),

                                  //]),

                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваше фото'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),

                                  Container(
                                    width: 130,
                                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(48))),
                                    child: FormBuilderFilePicker(
                                        name: "photo",
                                        decoration: const InputDecoration(
                                          fillColor: Color(0xff515569),
                                          iconColor: Colors.white,
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            //gapPadding: 40,
                                          ),
                                        ),
                                        maxFiles: null,
                                        previewImages: true,
                                        onChanged: (val) => {},
                                        selector: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          Stack(alignment: Alignment.center, children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 96,
                                              height: 96,
                                              decoration: const BoxDecoration(color: Color(0xFF515569), borderRadius: BorderRadius.all(Radius.circular(48))),
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/image.svg',
                                              semanticsLabel: 'Icon upload',
                                              height: 18.0,
                                            ),
                                          ]),
                                          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                            SizedBox(height: 40),
                                            Text('Загрузить фото',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'CadillacSans',
                                                    color: Color(0xFF515569),
                                                    height: 1.4 //line-height : font-size
                                                    ),
                                                textAlign: TextAlign.center),
                                            Icon(Icons.file_upload, semanticLabel: 'Icon upload', size: 18.0, color: Color(0xFF515569)),
                                            //)
                                          ]),
                                        ]),
                                        onFileLoading: (val) {
                                          // debugPrint(val);
                                        },
                                        onSaved: (value) => {
                                              photo = value!,
                                            }),
                                  ),

                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваше имя и фамилия'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'username',
                                      autofocus: true,
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите ваш имя",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      onSaved: (value) => username = value!,
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: FormBuilderValidators.compose([
                                        (val) {
                                          if (val == null) {
                                            return 'Поле name не может быть пустым';
                                          } else if (val.length < 3) {
                                            // return 'Invalid email address';
                                            return 'Минимум 3 символа';
                                          } else {
                                            return null;
                                          }
                                        }
                                      ]),
                                      keyboardType: TextInputType.text),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваша дата рождения'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                    name: 'birthday',
                                    cursorWidth: 1.0,
                                    cursorColor: Colors.white,
                                    style: styleFormInput,
                                    inputFormatters: [maskFormatterDate],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                      fillColor: Color(0XFF515569),
                                      filled: true,
                                      hintText: "__.__.____",
                                      hintStyle: TextStyle(
                                        color: Colors.white60,
                                      ),
                                    ),
                                    onSaved: (value) => birthday = value!,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваш номер телефона'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),

                                  FormBuilderTextField(
                                      name: 'phone2',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      inputFormatters: [maskFormatterPhone],
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
                                      keyboardType: TextInputType.text),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'ваше автомобиль'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'carname',
                                      cursorWidth: 1.0,
                                      cursorColor: Colors.white,
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите название автомобиля",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      onSaved: (value) => carname = value,
                                      keyboardType: TextInputType.text),

                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'загрузите 3 фото вашего cadillac'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderFilePicker(
                                      name: "cars",
                                      decoration: const InputDecoration(
                                        fillColor: Color(0xff515569),
                                        iconColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          //gapPadding: 40,
                                        ),
                                      ),
                                      maxFiles: null,
                                      previewImages: true,
                                      onChanged: (val) => {},
                                      selector: Column(children: [
                                        Stack(alignment: Alignment.center, children: [
                                          Container(
                                            //dding: EdgeInsets.only(bottom: 40),
                                            width: 284,
                                            height: 160,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF515569), shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10))),
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/load.svg',
                                            semanticsLabel: 'Icon upload',
                                            height: 18.0,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: const [
                                                  SizedBox(height: 40),
                                                  Text('Загрузить фото',
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: 'CadillacSans',
                                                          color: Colors.white,
                                                          height: 1.4 //line-height : font-size
                                                          ),
                                                      textAlign: TextAlign.center),
                                                  Icon(
                                                    Icons.file_upload,
                                                    semanticLabel: 'Icon upload',
                                                    size: 18.0,
                                                    color: Colors.white,
                                                  )
                                                ]),
                                          )
                                        ]),
                                      ]),
                                      onFileLoading: (val) {
                                        // debugPrint(val);
                                      },
                                      onSaved: (value) => {
                                            cars = value!,
                                          }),

                                  Container(
                                      width: 284,
                                      margin: const EdgeInsets.only(top: 30, bottom: 45),
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(17),
                                        color: const Color.fromARGB(255, 255, 255, 255),
                                        // textColor: const Color(0xFF12141F),
                                        child: Text(
                                          "зарегистрироваться".toUpperCase(),
                                          style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                        ),

                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState?.validate() == false) {
                                            debugPrint('Invalid');
                                            errorMessage(context);
                                          } else {
                                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                                              debugPrint('Valid success payment admin');
                                              Provider.of<Data>(context, listen: false).updateAccount(2);

                                              if (platform == 'android' || platform == 'ios') {
                                                debugPrint(platform);
                                                final bytes = File(photo[0].path).readAsBytesSync();

                                                setState(() {
                                                  encode64 = base64.encode(bytes);
                                                });

                                                debugPrint('cars.length');
                                                debugPrint(cars.length.toString());
                                                if (cars.length == 2) {
                                                  if (cars[0].path != null) {
                                                    final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                    car1 = base64.encode(bytesCar1);
                                                  } else {
                                                    car1 = '';
                                                  }
                                                  if (cars[1].path != null) {
                                                    final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                    car2 = base64.encode(bytesCar2);
                                                  } else {
                                                    car2 = '';
                                                  }
                                                  car3 = '';
                                                } else if (cars.length == 3) {
                                                  if (cars[0].path != null) {
                                                    final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                    car1 = base64.encode(bytesCar1);
                                                  } else {
                                                    car1 = '';
                                                  }
                                                  if (cars[1].path != null) {
                                                    final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                    car2 = base64.encode(bytesCar2);
                                                  } else {
                                                    car2 = '';
                                                  }
                                                  if (cars[2].path != null) {
                                                    final bytesCar3 = File(cars[2].path).readAsBytesSync();
                                                    car3 = base64.encode(bytesCar3);
                                                  } else {
                                                    car3 = '';
                                                  }
                                                } else {
                                                  final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                  car1 = base64.encode(bytesCar1);
                                                  car2 = '';
                                                  car3 = '';
                                                }
                                              } else {
                                                debugPrint(platform);
                                                bytes = photo[0].bytes;
                                                debugPrint('cars.length');
                                                debugPrint(cars.length.toString());
                                                if (cars.length == 2) {
                                                  if (cars[0].bytes != null) {
                                                    final bytesCar1 = cars[0].bytes;
                                                    car1 = base64.encode(bytesCar1!);
                                                  } else {
                                                    car1 = '';
                                                  }
                                                  if (cars[1].bytes != null) {
                                                    final bytesCar2 = cars[1].bytes;
                                                    car2 = base64.encode(bytesCar2!);
                                                  } else {
                                                    car2 = '';
                                                  }
                                                  car3 = '';
                                                } else if (cars.length == 3) {
                                                  if (cars[0].bytes != null) {
                                                    final bytesCar1 = cars[0].bytes;
                                                    car1 = base64.encode(bytesCar1!);
                                                  } else {
                                                    car1 = '';
                                                  }
                                                  if (cars[1].bytes != null) {
                                                    final bytesCar2 = cars[1].bytes;
                                                    car2 = base64.encode(bytesCar2);
                                                  } else {
                                                    car2 = '';
                                                  }
                                                  if (cars[2].bytes != null) {
                                                    final bytesCar3 = cars[2].bytes;
                                                    car3 = base64.encode(bytesCar3);
                                                  } else {
                                                    car3 = '';
                                                  }
                                                } else {
                                                  final bytesCar1 = cars[0].bytes;
                                                  car1 = base64.encode(bytesCar1);
                                                  car2 = '';
                                                  car3 = '';
                                                }
                                                setState(() {
                                                  encode64 = base64.encode(bytes!);
                                                });
                                              }

                                              debugPrint(userId);

                                              dynamic currentUser = User(
                                                  id: '1',
                                                  userId: userId,
                                                  phone: phone,
                                                  email: email,
                                                  username: username,
                                                  birthday: birthday,
                                                  login: login,
                                                  carname: carname,
                                                  password: password,
                                                  path: encode64,
                                                  car1: car1,
                                                  car2: car2,
                                                  car3: car3,
                                                  dateRegister: 'dateRegister',
                                                  dateExpired: 'dateExpired');

                                              findingUser = await getUserByEmail(currentUser);
                                              user = await editUser(currentUser);

                                              Provider.of<Data>(context, listen: false).updateAccount(2);

                                              await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountAdmin()));
                                            }
                                          }
                                        },
                                      )),

                                  Container(
                                    margin: const EdgeInsets.only(top: 0, bottom: 30),
                                    child: GestureDetector(
                                      onTap: _launchURL,
                                      // onTap: goToURL,
                                      child: const Text.rich(
                                        TextSpan(
                                            text: 'Продолжая вы принимаете ',
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF8F97BF), height: 1.5),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: 'Пользовательское соглашение и конфиденциальность',
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  decorationThickness: 2,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ]))
                          ])))
                ])),
              )
            ]),
          ),
          drawer: const NavDrawer(),
        ));
  }

  getPathImage(url) async {
    return url;
  }

  getUserByEmail(User user) async {
    debugPrint('func getUserByEmail');
    dynamic login = user.login;
    dynamic password = user.password;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    dynamic carname = user.carname;
    dynamic path = user.path;
    dynamic car1, car2, car3;
    if (user.car1 != 'null') car1 = user.car1;
    if (user.car2 != 'null') car2 = user.car2;
    if (user.car3 != 'null') car3 = user.car3;

    String apiUrl = baseUrl + "/test/get_user_by_email.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      'login': login,
      'username': username,
      'birthday': birthday,
      'carname': carname,
      'path': path,
      'car1': car1 != '' ? car1 : '',
      'car2': car2 != '' ? car2 : '',
      'car3': car3 != '' ? car3 : '',
      'password': password
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });
    if (response.statusCode == 200) {
      debugPrint('success getUserByEmail');
      debugPrint(response.body);
      final userJson = json.decode(response.body);
      var data = User.fromJson(userJson);
      debugPrint(data.userId);
      Provider.of<Data>(context, listen: false).updateUserId(data.userId);
      return (data);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  editUser(User user) async {
    debugPrint('func editUser success');

    dynamic login = user.login;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    dynamic carname = user.carname;
    dynamic path = user.path;
    dynamic car1, car2, car3;
    if (user.car1 != 'null') car1 = user.car1;
    if (user.car2 != 'null') car2 = user.car2;
    if (user.car3 != 'null') car3 = user.car3;

    String apiUrl = baseUrl + "/test/edit.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      'userId': userId,
      'login': login,
      'username': username,
      'birthday': birthday,
      'carname': carname,
      'path': path,
      'car1': car1,
      'car2': car2,
      'car3': car3,
      'password': 'password'
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      debugPrint('success success-payment');
      var cookie = response.headers['set-cookie'];
      debugPrint('cookie: $cookie'); //null
      debugPrint(response.body);

      final userJson = json.decode(response.body);
      var data = User.fromJson(userJson);

      if (mounted && userId != null) {
        setState(() {
          uuid = data.userId;
        });
      }
      //getCookie(data.userId);
      //return User.fromJson(userJson);
      return (data);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}

getCookie(cookie) async {
  debugPrint('get cookie');
  //var dio = Dio();
  //dynamic cookies = {"uuid", cookie};
  //var cookies = html.window.document.cookie;

  // List<Cookie> cookies = [
  //   new Cookie("uuid", cookie),
  //   // ....
  // ];

  // var cookieJar = PersistCookieJar();
  // dio.interceptors.add(CookieManager(cookieJar));
  // //Save cookies
  // cookieJar.saveFromResponse(Uri.parse(baseUrl), cookies);
  //
  // //Get cookies
  // cookieJar.loadForRequest(Uri.parse(baseUrl));
  // debugPrint(cookieJar.loadForRequest(Uri.parse(baseUrl)));

  //debugPrint(cookies);
  // await dio.get(baseUrl);
}

final Uri _url = Uri.parse('https://www.google.com');

void _launchURL() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
  // const url = 'https://www.google.com';  //наша ссылка
  // if (await canLaunchUrl(url)) {  //проверяем наличие браузера на устройстве
  //   await launchUrl(url, forceWebView: true);   //true если открываем в приложении, false открываем в браузере
  // } else {
  //   throw 'Could not launch $url';
}

Future errorMessage(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Все поля формы обязательны для заполнения'.toUpperCase(),
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
                      textAlign: TextAlign.right,
                      style: styleTextAlertDialog,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    }),
              ]))
        ],
      );
    },
  );
}
