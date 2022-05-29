import 'package:cadillac/main.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/success-payment.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:path_provider/path_provider.dart';

// import 'package:hive/hive.dart';


import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';



import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import 'package:cadillac/env.dart';
//import 'package:cadillac/db/connect.php';



import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:form_builder_asset_picker/form_builder_asset_picker.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/accordion.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/common/theme_helper.dart';

import 'package:cadillac/pages/account.dart';

import 'package:cadillac/models/user.dart';
//import 'package:cadillac/models/users.dart';
import 'dart:developer';
import 'package:flutter/services.dart';


import 'contacts.dart';
import 'home.dart';
import 'members.dart';
import 'news.dart';

class RegistrationPage extends StatelessWidget {

  RegistrationPage({Key? key, }) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();

  late dynamic userId = 'rgrr';
  late dynamic login;
  late dynamic name = 'ewrew';
  late dynamic email =' dgferger';
  late dynamic phone = 'erterert';
  final dynamic password ='123';
  final dynamic birthday = '111';
  late dynamic car;
  late dynamic type;
  final dynamic token = '1111';
  final dynamic renewalToken = '11111';

  late final dynamic photo = 'assets/images/avatar.png';
  /*late final dynamic cars = const [ 'assets/images/cadillac-eldorado.png',
    "assets/images/cadillac-escalada.png",
    "assets/images/cadillac-orange.png",
  ];*/


  // dynamic id;

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );


  dynamic currentUser;
  dynamic newUser;
  dynamic user;

  //User newUser = User(); нужен только импорт модели юзер
  //User newUser = User();

  // void dispose() {
  //   // _nameController.dispose();
  //   // _phoneController.dispose();
  //   _emailController.dispose();
  //   // _storyController.dispose();
  //   // _passController.dispose();
  //   // _confirmPassController.dispose();
  //   // _nameFocus.dispose();
  //   // _phoneFocus.dispose();
  //   // _passFocus.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    //currentUser = addUser();
    //print(currentUser);


    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        // Английский, без кода страны Locale ( 'es' , '' ), // испанский, без кода страны ],
      ],


      //initialRoute: '/home',

      routes: {
        '/home': (context) => const Home(),
        // '/home': (context) => RegistrationPage(),
        '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),
          '/success_payment': (context) => SuccessPayment(currentUser: currentUser),

      },
      home: Scaffold(
        body: Center (
          child: Container (
              width: 284,

              child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded (
                        child: SingleChildScrollView (

                              child: Column(
                                children: [
                                  Container (
                                    margin: const EdgeInsets.only(bottom: 70, top: 70),
                                    child: SvgPicture.network(
                                      'assets/images/LOGO.svg',
                                      height: 103.0,
                                      color: Colors.white,
                                    ),
                                  ),

                                  FormBuilder(
                                      key: _formKey,
                                      autovalidateMode: AutovalidateMode.always,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 10),
                                              child: Text('ваш email'.toUpperCase(),
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
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),

                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "Введите ваш email",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                // onChanged: _onChanged,

                                                valueTransformer: (text) => num.tryParse(text!),
                                                autovalidateMode: AutovalidateMode.always,
                                                // validator: _validateEmail,
                                                controller: _emailController,
                                                onSaved: (value) => email = value!,
                                                validator: FormBuilderValidators.compose([
                                                  // FormBuilderValidators.required(context, errorText: 'Обязательное поле'),
                                                      (val) {
                                                    if (val == '') {
                                                      return 'Поле email не может быть пустым';
                                                    } else if (!_emailController.text.contains('@')) {
                                                      // return 'Invalid email address';
                                                      return 'Неверный email адрес';
                                                    } else {
                                                      return null;
                                                    }
                                                  }

                                                  // FormBuilderValidators.max(context, 20),
                                                  // FormBuilderValidators.email(context),
                                                ]),
                                                keyboardType: TextInputType.emailAddress
                                            ),

                                            Container(
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text('ваш номер телефона'.toUpperCase(),
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
                                                // decoration: ThemeHelper().textInputDecoration('+7 ___-___-__-__', '', ''),
                                                autovalidateMode: AutovalidateMode.always,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),

                                                  fillColor: Color(0XFF515569),
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

                                                validator: FormBuilderValidators.compose([
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
                                                onSaved: (value) => phone = value!,
                                                keyboardType: TextInputType.phone
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
                                      child: Text.rich(
                                        TextSpan (
                                            text: 'войти/'.toUpperCase(),
                                            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Color(0xFF12141F), height: 1.14),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: 'стать членом \nавтоклуба cadillac'.toUpperCase(),
                                                style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: Color(0xFF12141F), height: 1.14),
                                              )
                                            ]
                                        ),
                                      ),

                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        debugPrint('onPressed');
                                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                                          if (true) {
                                            // Either invalidate using Form Key
                                            _formKey.currentState?.invalidateField(
                                                name: 'email',
                                                errorText: 'Email already taken.');
                                            // OR invalidate using Field Key
                                            // _emailFieldKey.currentState?.invalidate('Email already taken.');
                                          }

                                          debugPrint('Valid registr');

                                          _formKey.currentState?.save();
                                          //User user = User(name: 'Konstantin', age: 34);
                                          final user = User(email: email, phone :phone);
                                          //startLogin();

                                          // var uuid = const Uuid();
                                          // id = uuid.v1();
                                          //currentUser = addUser(user);
                                          //newUser = addUser();
                                          //print(currentUser);
                                          addUser(user);
                                          debugPrint('after addUser registr');
                                          // print('id: $id');

                                          // Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                              context, MaterialPageRoute(
                                            builder: (context) =>
                                            // SuccessPayment(),
                                            SuccessPayment(
                                                currentUser: user),
                                          )
                                          );

                                        } else {
                                          debugPrint('Invalid');
                                        }
                                        // debugPrint(_formKey.currentState?.value.toString());

                                        // Box<User> contactsBox = Hive.box<User>(HiveBoxes.user);
                                        // contactsBox.add(User(email: email, phone: phone));
                                        // userBox.putAll({email: email, phone : phone});
                                        // print('Email: ${userBox.getAt(0)?.email}');

                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text('Скачать'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),

                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(

                                          //height: 48,
                                          padding: const EdgeInsets.all(17),
                                          // color: const Color(0xFF515569),
                                          // child: Image(
                                          //   image:  NetworkImage('assets/images/app01.png',),
                                          //   fit: BoxFit.fill,
                                          // ),
                                          child: Image(
                                            width: 110,
                                            image:  NetworkImage('assets/images/app01.png',),
                                            fit: BoxFit.fill,
                                          ),
                                          // shape: const RoundedRectangleBorder(
                                          //   side: BorderSide.none,
                                          //   borderRadius: BorderRadius.all(Radius.circular(10),
                                          //   ),
                                          // ),
                                          onPressed: () {  },
                                        ),

                                        MaterialButton(

                                          ////height: 48,
                                          padding: const EdgeInsets.all(17),
                                          // color: const Color(0xFF515569),

                                          child: Image(
                                            width: 110,
                                            image:  NetworkImage('assets/images/app02.png',),
                                            fit: BoxFit.fill,
                                          ),
                                          //   shape: const RoundedRectangleBorder(
                                          //     side: BorderSide.none,
                                          //     borderRadius: BorderRadius.all(Radius.circular(10),
                                          //   ),
                                          // ),
                                          onPressed: () {  },
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


  String? _validateEmail(String? value) {
    if (value == null) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      // return 'Invalid email address';
      return 'Неверный email адрес';
    } else {
      return null;
    }
  }

  addUser(User user) async {
    print('func addUser registr');
    print(user.email);
    dynamic phone = user.phone;
    dynamic email = user.email;
    // late dynamic userId ='yyyyy';

    String apiurl = "http://localhost/test/create.php";
    // var response = await http.post(Uri.parse(apiurl),body:{'userId': userId,'phone': phone,'email': email});
    var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}, body:{'phone': phone,'email': email});
    // final response = await http.post(Uri.parse(apiurl));

    print('after response registr');
    //print(User.fromJson(jsonDecode(response.body)));

    if(response.statusCode == 200){
        print('success registr code');
        // var uuid = const Uuid();
        // id = uuid.v1();
        print(response.statusCode);

        print('response.body registr');
        print(response);
        print(response.body); // пустая стрка в консоли вне зависимости от передачи боди)
        // currentUser = json.decode(response);
        // print(currentUser);
        print('after json.decode registr');
        return response.body;
        //return User.fromJson(currentUser); // error
        //return User.fromJson(jsonDecode(response.body));
        // setState(() {
        //   showprogress = false; //don't show progress indicator
        //   error = true;
        //   errormsg = jsondata["message"];
        // });

    }else{
      print('error');
      throw Exception('We were not able to successfully download the json data.');
    }
    //return response.body;
    //return User.fromJson(json.decode(response.body));
  }

  startLogin() async {
    print('startLogin');
    // String apiurl = "http://192.168.31.213/test/login.php"; //api url no  work, login.php - error
    String apiurl = "http://localhost/test/create.php"; //api url
    print(apiurl);
    // print("userId : $userId");  no field form
    // print("phone2 : $phone");
    // print("email2: $email");

    // final response = await http.post(Uri.parse(apiurl),body:{'userId': userId, 'phone': phone,'email': email}, headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
    final response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});


    print('response body start login');

    //print(json.decode(response.body));
    //return User.fromJson(jsonDecode(response.body));




    if(response.statusCode == 200){

      print(response.statusCode);

      print('response.body');
      print(response.body);
      currentUser = json.decode(response.body);
      //print(User.fromJson(jsonDecode(response.body)));
        // var uuid = const Uuid();
        // id = uuid.v1();
      //return response.body;
      return User.fromJson(json.decode(response.body));
      //return User.fromJson(jsonDecode(response.body));
      // return UsersList.fromJson(json.decode(response.body));
      // dynamic user = User.fromJson(jsonDecode(response.body));
      // print('user: ${user}');
      // return User.fromJson(jsonDecode(response.body));
        // setState(() {
        //   showprogress = false; //don't show progress indicator
        //   error = true;
        //   errormsg = jsondata["message"];
        // });
      } else {
        print('error');
        throw Exception('We were not able to successfully download the json data.');
      }
    //return response.body;
    //return User.fromJson(jsonDecode(response.body));
  }

  void _onChanged() {
  }
}
