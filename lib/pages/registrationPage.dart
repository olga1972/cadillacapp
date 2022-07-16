// import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:http/http.dart' as html;


import 'package:cadillac/pages/homeAdmin.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/registrationAdmin.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/success-payment.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cadillac/pages/data.dart';


// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:cookie_jar/cookie_jar.dart';

//import 'package:requests/requests.dart';
// import 'package:hive/hive.dart';



import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';




//import 'package:cadillac/db/connect.php';



import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



import 'package:cadillac/variables.dart';

import 'package:cadillac/pages/account.dart';


import 'package:cadillac/models/users.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import '../main.dart';
import 'accountAdmin.dart';
import 'contacts.dart';
import 'data.dart';
import 'home.dart';

var uuid = '';
late bool isAuth;


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key, }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {


  @override
  void initState() {
    super.initState();


    setState(() {
      uuid = '';
      isAuth = false;
    });
  }


  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();

  late dynamic userId;
  late dynamic login;
  late dynamic username = 'ewrew';
  late dynamic email = ' dgferger';
  late dynamic phone = 'erterert';
  final dynamic password = '123';
  final dynamic birthday = '111';
  late dynamic carname = 'carname';
  late dynamic path = 'path';
  late dynamic car1 = 'car1';
  late dynamic car2 = 'car2';
  late dynamic car3 = 'car3';

  late dynamic userIdFromProvider;

  //late String path = "assets/images/avatar.png";
  // late dynamic type;
  // final dynamic token = '1111';
  // final dynamic renewalToken = '11111';

  //XFile? photo = ImagePicker().pickImage(source: ImageSource.gallery) as XFile?;
  /*late final dynamic cars = const [ 'assets/images/cadillac-eldorado.png',
    "assets/images/cadillac-escalada.png",
    "assets/images/cadillac-orange.png",
  ];*/

  var cookie;
  var counter;

  // dynamic id;

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );


  dynamic currentUser;
  dynamic newUser;
  dynamic user;

  final Uri url1 = Uri.parse('https://cadillacapp.ru/test/download.php');
  // final Uri url2 = Uri.parse('https://cadillacapp.ru/test/download2.php');


  //final directory = getApplicationDocumentsDirectory();


  //User newUser = User(); нужен только импорт модели юзер
  //User newUser = User();
  // _checkIsAuth(BuildContext context) {
  //   print('_checkIsAuth');
  //   print(Provider.of<Data>(context).data['userId'].toString());
  //   //Provider.of<Data>(context, listen: false ).checkIsAuth();
  // }
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
  // updateAccount(value) {
  //   print('update account');
  //   // data["userId"] = value;
  //   // //data["isAuth"] = true;
  //   // notifyListeners();
  // }

  @override
  Widget build(BuildContext context) {
    print('registr page');
    print(isAuth);
    //userId = Provider.of<Data>(context, listen: false).data['userId'].toString();
    // platform = Provider.of<Data>(context).data['platform'].toString();
    // print(platform);
    // print('userId from provider');
    // print(userId);
    counter = Provider
        .of<Data>(context)
        .data['counter'].toString();
    print('counter');
    print(counter);
    var minHeight = MediaQuery.of(context).size.height;
    if (counter == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder:
                  (context) =>
                  SuccessPayment()));
    } else if (counter == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder:
                  (context) =>
                  Account()));
    }


    userIdFromProvider = Provider
        .of<Data>(context, listen: false)
        .data['userId'].toString();
    print(Provider
        .of<Data>(context, listen: false)
        .data['userId'].toString());
    Future.delayed(Duration.zero, () {
      //user = getUser('e02b9830-01c2-11ed-8ee7-a37307107e52');
      // try{
      //   //user = getUser(Provider.of<Data>(context, listen: false).data['userId'].toString());
      //   user = getUser('e02b9830-01c2-11ed-8ee7-a37307107e52');
      //   print('try');
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder:
      //               (context) =>
      //               Account()));
      //
      // }
      // catch(e){
      //   print("Возникло исключение $e");
      // }


// print('after try');
//         print(isAuth);
      // print('snapshot');
      // print(user.userId);

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder:
      //             (context) =>
      //             Account()));
      //_checkIsAuth(context);
      //print(Provider.of<Data>(context, listen: false).data['userId'].toString());

      // cookie = Provider.of<Data>(context, listen: false).data['userId'].toString();
      // counter = Provider.of<Data>(context, listen: false).data['counter'].toString();
      // print(cookie);
      // if(cookie != null && counter == 1) {
      //   print('cookie yes');
      //
      //   Provider.of<Data>(context, listen: false).data['userId'].toString();
      //   //print(Provider.of<Data>(context).data['userId'].toString());
      //   print(Provider.of<Data>(context, listen: false).data['userId'].toString());
      //   print(Provider.of<Data>(context, listen: false).data['counter'].toString());
      //   print(Provider.of<Data>(context, listen: false).data['isAuth'].toString());
      //
      //   //updateAccount(Provider.of<Data>(context).data['userId'].toString());
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder:
      //               (context) =>
      //               Account()));
      // } else {
      //   print('cookie no');
      //   print(Provider.of<Data>(context, listen: false).data['userId'].toString());
      //   print(Provider.of<Data>(context, listen: false).data['counter'].toString());
      //   print(Provider.of<Data>(context, listen: false).data['isAuth'].toString());
      // }
    });


    //currentUser = addUser();
    //print(currentUser);
    //getCookie();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Клуб Любителей Кадиллак в России',
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        supportedLocales: const [
          Locale('en', ''),
          // Английский, без кода страны Locale ( 'es' , '' ), // испанский, без кода страны ],
        ],


        //initialRoute: '/home',

        routes: {
          '/home': (context) => const Home(),
          '/homeAdmin': (context) => const HomeAdmin(),
          '/account': (context) => Account(),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          '/shop': (context) => const Shop(),
          '/partners': (context) => const Partners(),
          '/contacts': (context) => const Contacts(),
          // '/success_payment': (context) => SuccessPayment(currentUser: currentUser),
          '/success_payment': (context) => SuccessPayment()
        },
        home: Scaffold(
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
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 70,
                                          top: 70),
                                      child: SvgPicture.asset(
                                        'assets/images/LOGO.svg',
                                        //fit: BoxFit.fill,
                                        height: 103.0,
                                        color: Colors.white,
                                      ),
                                      // child: SvgPicture.network(
                                      //   'assets/images/LOGO.svg',
                                      //   height: 103.0,
                                      //   color: Colors.white,
                                      // ),
                                    ),

                                    FormBuilder(
                                        key: _formKey,
                                        autovalidateMode: AutovalidateMode
                                            .always,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Container(
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
                                                  // decoration: ThemeHelper().textInputDecoration('', 'Введите ваш email', 'Введите ваш email'),
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
                                                  // onChanged: _onChanged,

                                                  valueTransformer: (text) =>
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
                                                      if (!_emailController.text
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
                                                  // onChanged: _onChanged,

                                                  // valueTransformer: (text) => num.tryParse(text),
                                                  // validator: (value) => _validatePhoneNumber(value!)
                                                  //     ? null
                                                  //     : 'Phone number must be entered as (###)###-####',

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
                                            ]
                                        )
                                    ),
                                    Container(
                                      width: 284,
                                      margin: const EdgeInsets.only(top: 30,
                                          bottom: 45),
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(17),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        // textColor: const Color(0xFF12141F),
                                        child: Text.rich(
                                          TextSpan(
                                              text: 'войти/'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF12141F),
                                                  height: 1.14),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: 'стать членом \nавтоклуба cadillac'
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Color(0xFF12141F),
                                                      height: 1.14),
                                                )
                                              ]
                                          ),
                                        ),

                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {

                                          if (_formKey.currentState
                                              ?.saveAndValidate() ?? false) {
                                            debugPrint('valid');

                                          if(email == 'admin@admin') {
                                              Provider.of<Data>(context, listen: false).updateAccount(1);
                                              Navigator.pushReplacement(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                RegistrationAdmin()
                                           ));

                                          } else {
                                            confirmDialog(context);
                                          }

                                          } else {
                                            debugPrint(
                                                'Invalid');
                                            errorMessage(context);
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
                                              // color: const Color(0xFF515569),
                                              child: Image.asset(
                                                'assets/images/app1.png',
                                                fit: BoxFit.contain,
                                                height: 58,
                                              ),
                                              // shape: const RoundedRectangleBorder(
                                              //   side: BorderSide.none,
                                              //   borderRadius: BorderRadius.all(Radius.circular(10),
                                              //   ),
                                              //),
                                              onPressed: () {
                                                launchURL(url1);
                                                //downLoadApp();
                                                // Navigator
                                                //     .pushReplacement(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             Home()
                                                //     ));
                                              }),

                                          MaterialButton(
                                            //width: 110,

                                            padding: const EdgeInsets.all(17),
                                            // color: const Color(0xFF515569),

                                            child: Image.asset(
                                              'assets/images/app2.png',
                                              fit: BoxFit.contain,
                                              height: 58,
                                            ),
                                            onPressed: () {
                                              //launchURL(url2);
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

  // addUser(User user) async {
  //   // var uuid = const Uuid();
  //   // var id = uuid.v1();
  //   print('func addUser registr');
  //
  //   dynamic phone = user.phone;
  //   dynamic email = user.email;
  //   //dynamic path = user.path;
  //   //(path);
  //   dynamic userId = user.userId;
  //
  //
  //   String apiurl = baseUrl + "/test/create.php";
  //   //print(baseUrl + "/test/create.php");
  //   //String apiurl = "http://localhost/test/create.php";
  //   // var response = await http.post(Uri.parse(apiurl),body:{'userId': userId,'phone': phone,'email': email});
  //   var response = await http.post(Uri.parse(apiurl), headers: {
  //     'Accept': 'application/json, charset=utf-8',
  //     "Access-Control-Allow-Origin": "*",
  //     "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  //   },
  //       body: {
  //         'userId': userId,
  //         'path': 'path',
  //         'phone': phone,
  //         'email': email
  //       });
  //
  //   // final response = await http.post(Uri.parse(apiurl));
  //   //print(User.fromJson(jsonDecode(response.body)));
  //
  //   if (response.statusCode == 200) {
  //     print('success registr code');
  //     cookie = response.headers['set-cookie'];
  //     print('cookie: $cookie');
  //     List<String>? cookiesList = cookie?.split(';');
  //     cookiesList?.forEach((i) => print(i.toLowerCase().trim()));
  //     userId = cookiesList?[0].split('=')[1];
  //
  //     updateAccount(userId);
  //     print(Provider
  //         .of<Data>(context, listen: false)
  //         .data['userId'].toString());
  //     print('userId: $userId');
  //
  //     if (mounted && userId != null) {
  //       setState(() {
  //         uuid = userId;
  //         isAuth = true;
  //       });
  //     }
  //     //Provider.of<Data>(context, listen: false).updateAccount(uuid);
  //     // var uuid = const Uuid();
  //     // var id = uuid.v1();
  //     print(response.statusCode);
  //     print(response.body);
  //     print(json.decode(response.body));
  //     final userJson = json.decode(response.body);
  //     //final userJson = response.body;
  //     print('userJson registr');
  //     // print(userJson);
  //
  //     dynamic data = User.fromJson(userJson);
  //     // return User.fromJson(userJson);
  //     return data;
  //
  //     //return response.body; //это правильно
  //     //return User.fromJson(currentUser); // error
  //     //return User.fromJson(jsonDecode(response.body));
  //     // setState(() {
  //     //   showprogress = false; //don't show progress indicator
  //     //   error = true;
  //     //   errormsg = jsondata["message"];
  //     // });
  //
  //   } else {
  //     print('error');
  //     throw Exception(
  //         'We were not able to successfully download the json data.');
  //   }
  //   //return response.body;
  //   //return User.fromJson(json.decode(response.body));
  // }

  Future confirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Подтвердить регистрацию?'.toUpperCase(),
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
                        onPressed: () async {
                              final request = Request(
                                email: email,
                                phone: phone,
                                theme: 'Запрос на регистрацию',
                                message: 'Хочу зарегистрироваться в приложении Cadillac',
                              );
                              send(request);
                              Provider.of<Data>(context, listen: false).updateAccount(1);

                              Navigator.of(context).pop();

                              await Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context) =>
                              SuccessPayment()
                              ));

                              _formKey.currentState?.save();
                              //User user = User(name: 'Konstantin', age: 34);
                              // var uuid = const Uuid();
                              // var userId = uuid.v1();
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

  Future errorMessage(BuildContext context) async {
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
                          onPressed: () async {
                            Navigator.of(context).pop();

                            // await Navigator.pushReplacement(
                            //     context, MaterialPageRoute(
                            //     builder: (context) =>
                            //         SuccessPayment()
                            // ));
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

  Future getUser(userId) async {
    print('getUser registr page');
    print('userId: $userId');
    //String apiurl = "http://localhost/test/get_user.php";
    String apiurl = baseUrl + "/test/get_user.php"; // get jsonplaceholder


    final response = await http.post(
        Uri.parse(apiurl), body: {'userId': userId},
        headers: {
          'Accept': 'application/json, charset=utf-8',
          "Access-Control-Allow-Origin": "http://localhost:59369",
          "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
        });
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print(response);
      final userJson = json.decode(response.body);
      var data = User.fromJson(userJson);
      Provider.of<Data>(context, listen: false).updateUserId(data.userId);
      // print('data.userId');
      // print(data.userId);
      //
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      //
      //return User.fromJson(userJson);
      return(data);
      //return true;
      return userJson.map((json) => User.fromJson(userJson));
    } else {
      throw Exception('Error fetching users');
    }
  }

  send(Request request) async {
    dynamic email = request.email;
    dynamic phone = request.phone;
    dynamic theme = request.theme;
    dynamic message = request.message;

    // String apiurl = "http://localhost/test/mail_request.php";
    String apiurl = baseUrl + "/test/mail_request.php";

    var response = await http.post(Uri.parse(apiurl), body: {
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



  getCookie() async {
    print('get cookie');
    var dio = Dio();
    dynamic cookies = {"uuid", "9265988f-e70d-11ec-af6a-00ff21c5bb0a"};


      // List<Cookie> cookies = [
      //   new Cookie("uuid", "9265988f-e70d-11ec-af6a-00ff21c5bb0a"),
      //   // ....
      // ];


      var cookieJar = PersistCookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      //Save cookies
      //cookieJar.saveFromResponse(Uri.parse("http://localhost"), cookies);

    //Get cookies
      cookieJar.loadForRequest(Uri.parse(baseUrl));
      print(cookieJar.loadForRequest(Uri.parse(baseUrl)));

      //print(cookies);
      await dio.get(baseUrl);
  }


  void _onChanged() {
  }



downLoadApp() async {

  print('download');

  String apiurl = baseUrl + "/test/download.php";
  print(apiurl);

  var response = await http.post(Uri.parse(apiurl));

  if(response.statusCode == 200){
    print('success download');
    print(response.statusCode);
    return true;
  }else{
    print('error');
    throw Exception('We were not able to successfully download the json data.');
  }

}




void launchURL(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
  // const url = 'https://www.google.com';  //наша ссылка
  // if (await canLaunchUrl(url)) {  //проверяем наличие браузера на устройстве
  //   await launchUrl(url, forceWebView: true);   //true если открываем в приложении, false открываем в браузере
  // } else {
  //   throw 'Could not launch $url';
}