//import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/registrationPage.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/widgets/uploadImage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
// import 'generated/l10n.dart';

// import 'package:hive/hive.dart';
// import 'package:requests/requests.dart';

// import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid_util.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:html' as html;

import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

// import 'package:cross_file_image/cross_file_image.dart';


import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// import 'package:image/image.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:form_builder_asset_picker/form_builder_asset_picker.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/accordion.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/common/theme_helper.dart';

import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/home.dart';

import 'package:cadillac/models/users.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:cadillac/env.dart';

import 'accountAdmin.dart';
import 'contacts.dart';
import 'members.dart';
import 'news.dart';

import 'package:cadillac/utils/shared_preference.dart';

enum ImageSourceType { gallery, camera }

var uuid = '';

class RegistrationAdmin extends StatefulWidget {

  //var currentUser;
  //final User currentUser;
  //final User userId;

  // SuccessPayment({Key? key, required this.currentUser,} ) : super(key: key);
  RegistrationAdmin({Key? key, required this.userId} ) : super(key: key);

  late dynamic userId;
  late String path;


  get appDocPath => null;





  @override
  State<RegistrationAdmin> createState() => _RegistrationAdminState();
}

class _RegistrationAdminState extends State<RegistrationAdmin> {
  //String filePath = '';



  // getImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool check = prefs.containsKey('image');
  //   if (check) {
  //     setState(() {
  //       //filePath = prefs.getString('image')!;
  //     });
  //     return;
  //   }
  //
  // }

  dynamic user;

  @override
  initState()  {
    super.initState();

    // SharedPreferences.getInstance()
    //   ..then((prefs) {
    //     setState(() => this._prefs = prefs);
    //     _getUserIdPref();
    //
    //   });

    uuid = '';
    //uuid = userId;


    var path = "assets/images/avatar.png";
    print(path);
    print(uuid);

    // setState(() {
    //     userId = userId;
    // });

  }



  final _formKey = GlobalKey<FormBuilderState>();

  late dynamic userId = uuid;
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
  // late final dynamic token = '12345678';
  // late final dynamic renewalToken = '12345678';
  // late final dynamic photo = new ApiImage(imageUrl: 'assets/images/avatar.png', id: '1');
  //late dynamic photo = ('assets/images/avatar.png');
  //late XFile? photo;

  late List<dynamic> photo;
  late List<dynamic> cars;

  //User newUser = User();

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+7 ___-___-__-__',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  var maskFormatterDate = MaskTextInputFormatter(
      mask: '__.__.____',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  final _emailController = TextEditingController();

  //dynamic id;


  @override
  Widget build(BuildContext context) {
    dynamic user;

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        supportedLocales: [
          Locale('en', ''),
          // Английский, без кода страны Locale ( 'es' , '' ), // испанский, без кода страны ],
        ],



        routes: {
          '/home': (context) => Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          //  '/members': (context) => Members(),
          //  '/news': (context) => const News(),
          '/shop': (context) => Shop(),
          '/partners': (context) => Partners(),
          '/contacts': (context) => Contacts(),

        },
        home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          // ),

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
                                  margin: const EdgeInsets.only(
                                      bottom: 56),
                                  child:

                                  FormBuilder(
                                      key: _formKey,
                                      autovalidateMode: AutovalidateMode
                                          .always,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[

                                            Container(
                                              width: 284,
                                              margin: const EdgeInsets
                                                  .only(top: 30,
                                                  bottom: 10),
                                              child: Column(
                                                  children: [
                                                    Container(

                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 53,
                                                          bottom: 40),
                                                      child: const TitlePage(
                                                          title:
                                                          'регистрация администратора \nавтоклуба cadillac'),
                                                    ),
                                                    Container(
                                                      width: 284,
                                                      margin: const EdgeInsets
                                                          .only(bottom: 10),
                                                      child: Text(
                                                        'ваш логин'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),
                                                    FormBuilderTextField(
                                                        name: 'login',
                                                        // readOnly: true,
                                                        // enabled: false,
                                                        //initialValue: '${snapshot.data?.email}',

                                                        autofocus: true,
                                                        cursorWidth: 1.0,
                                                        cursorColor: Colors
                                                            .white,
                                                        style: styleFormInput,
                                                        // decoration: ThemeHelper().textInputDecoration('', 'Введите ваш логин', ''),
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets
                                                              .all(16),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide
                                                                  .none,
                                                              borderRadius: BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                      10))
                                                          ),

                                                          fillColor: Color(
                                                              0XFF515569),
                                                          filled: true,
                                                          hintText: "Введите ваш логин (email)",
                                                          hintStyle: TextStyle(
                                                            color: Colors
                                                                .white60,
                                                          ),
                                                        ),
                                                        // controller: _emailController,
                                                        // onChanged: _onChanged,
                                                        // valueTransformer: (text) => num.tryParse(text),
                                                        autovalidateMode: AutovalidateMode
                                                            .always,
                                                        // validator:
                                                        //   FormBuilderValidators.compose([
                                                        //     FormBuilderValidators.required(context),
                                                        //     // FormBuilderValidators.numeric(),
                                                        //     FormBuilderValidators.max(context, 10, errorText: 'Максимум 20 символов'),
                                                        //     FormBuilderValidators.min(context, 8, errorText: 'Минимум 8 символа'),
                                                        //   ]),
                                                        keyboardType: TextInputType
                                                            .emailAddress,
                                                        onSaved: (value) =>
                                                        login = value!),
                                                    Container(
                                                      width: 284,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваш пароль'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),
                                                    FormBuilderTextField(
                                                        name: 'password',
                                                        cursorWidth: 1.0,
                                                        autofocus: true,
                                                        cursorColor: Colors
                                                            .white,
                                                        style: styleFormInput,
                                                        obscureText: true,
                                                        // decoration: ThemeHelper().textInputDecoration('Введите ваш пароль', 'Введите ваш пароль', ''),
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets
                                                              .all(16),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide
                                                                  .none,
                                                              borderRadius: BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                      10))
                                                          ),

                                                          fillColor: Color(
                                                              0XFF515569),
                                                          filled: true,
                                                          hintText: "Введите ваш password",
                                                          hintStyle: TextStyle(
                                                            color: Colors
                                                                .white60,
                                                          ),
                                                        ),
                                                        // onChanged: _onChanged,
                                                        // valueTransformer: (text) => num.tryParse(text),
                                                        autovalidateMode: AutovalidateMode
                                                            .always,
                                                        validator: FormBuilderValidators
                                                            .compose([
                                                          // FormBuilderValidators.required(context, errorText: 'Обязательное поле'),
                                                              (val) {
                                                            if (val ==
                                                                null) {
                                                              return 'Поле password не может быть пустым';
                                                            } else
                                                            if (val.length <
                                                                8) {
                                                              // return 'Invalid email address';
                                                              return 'Минимум 8 символов';
                                                            } else {
                                                              return null;
                                                            }
                                                          }

                                                          // FormBuilderValidators.max(context, 20),
                                                          // FormBuilderValidators.email(context),
                                                        ]),
                                                        // validator:
                                                        // FormBuilderValidators.compose([
                                                        //   FormBuilderValidators.required(context, errorText: 'Поле обязательно для заполнения'),
                                                        //   // FormBuilderValidators.numeric(context, errorText: 'Можно вводить только цифры'),
                                                        //   FormBuilderValidators.min(context, 8, errorText: 'Минимум 8 символов'),
                                                        // ]),
                                                        // keyboardType: TextInputType.visiblePassword,
                                                        onSaved: (value) =>
                                                        password = value!
                                                    ),

                                                    //]),

                                                    Container(
                                                      width: 284,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваше фото'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),

                                                    Container(
                                                      //width: 140,
                                                      width: 284,
                                                      //margin: EdgeInsets.only(left: 20),
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  48))
                                                      ),
                                                      // child: Column(
                                                      //   children: [
                                                      // file == null
                                                      // ? Text('Click floating button to pick some image')
                                                      //       : Image(image: XFileImage(file!)),


                                                      // MaterialButton(
                                                      //   onPressed: () async {
                                                      //
                                                      //   },
                                                      //   ///tooltip: 'Pick Image',
                                                      //   child: Icon(Icons.add),
                                                      // ),
                                                      //  ]

                                                      // child: uploadImage(
                                                      //
                                                      //     maxImages: 1),

                                                      child: FormBuilderImagePicker(
                                                        name: 'photo',
                                                        // previewHeight: 96,
                                                        // previewWidth: 96,
                                                        // previewMargin: EdgeInsets.symmetric(horizontal: 150),
                                                        previewHeight: 140,
                                                        previewWidth: 284,
                                                        previewMargin: EdgeInsets.only(bottom: 0),
                                                        iconColor: Colors.white,
                                                        decoration: const InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20)
                                                              )
                                                          ),

                                                          // labelText: 'Загрузить фото',
                                                          // labelStyle: styleHelperText,
                                                        ),
                                                        maxImages: 1,
                                                        onSaved: (
                                                            value) =>
                                                        photo = value!,

                                                      ),

                                                    ),


                                                    Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваше имя и фамилия'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),
                                                    FormBuilderTextField(
                                                        name: 'username',
                                                        autofocus: true,
                                                        cursorWidth: 1.0,
                                                        cursorColor: Colors
                                                            .white,
                                                        style: styleFormInput,
                                                        // decoration: ThemeHelper()
                                                        //     .textInputDecoration(
                                                        //     '', 'Денис Антонов',
                                                        //     'Введите ваше Имя и Фамилию')
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets
                                                              .all(
                                                              16),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide
                                                                  .none,
                                                              borderRadius: BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                      10))
                                                          ),

                                                          fillColor: Color(
                                                              0XFF515569),
                                                          filled: true,
                                                          hintText: "Введите ваш имя",
                                                          hintStyle: TextStyle(
                                                            color: Colors
                                                                .white60,
                                                          ),
                                                        ),
                                                        onSaved: (
                                                            value) =>
                                                        username =
                                                        value!,
                                                        // onChanged: _onChanged,
                                                        // valueTransformer: (text) => num.tryParse(text),
                                                        autovalidateMode: AutovalidateMode
                                                            .always,
                                                        validator: FormBuilderValidators
                                                            .compose(
                                                            [
                                                                  (
                                                                  val) {
                                                                if (val ==
                                                                    null) {
                                                                  return 'Поле name не может быть пустым';
                                                                } else
                                                                if (val
                                                                    .length <
                                                                    3) {
                                                                  // return 'Invalid email address';
                                                                  return 'Минимум 3 символа';
                                                                } else {
                                                                  return null;
                                                                }
                                                              }
                                                              //   FormBuilderValidators.required(context, errorText: 'Поле обязательно для заполнения'),
                                                              //   FormBuilderValidators.min(context, 3, errorText: 'Минимум 3 символа'),
                                                              //   FormBuilderValidators.max(context, 20, errorText: 'Максимум 20 символов'),
                                                            ]),
                                                        keyboardType: TextInputType
                                                            .text),
                                                    Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваша дата рождения'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),
                                                    FormBuilderTextField(
                                                      name: 'birthday',
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors
                                                          .white,
                                                      style: styleFormInput,
                                                      inputFormatters: [
                                                        maskFormatterDate
                                                      ],
                                                      keyboardType: TextInputType
                                                          .number,
                                                      // decoration: ThemeHelper().textInputDecoration('', '__.__.____','Введите вашу дату рождения'),
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets
                                                            .all(
                                                            16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius
                                                                    .circular(
                                                                    10))
                                                        ),

                                                        fillColor: Color(
                                                            0XFF515569),
                                                        filled: true,
                                                        hintText: "__.__.____",
                                                        hintStyle: TextStyle(
                                                          color: Colors
                                                              .white60,
                                                        ),
                                                      ),
                                                      onSaved: (
                                                          value) =>
                                                      birthday =
                                                      value!,
                                                      // onChanged: _onChanged,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // autovalidateMode: AutovalidateMode.always,
                                                      // validator: FormBuilderValidators.compose([
                                                      //   FormBuilderValidators.dateString(context, errorText: 'Вы ввели не дату'),
                                                      //   FormBuilderValidators.required(context, errorText: 'Поле обязательно для заполнения'),
                                                      //   FormBuilderValidators.numeric(context, errorText: 'Можно вводить только цифры'),
                                                      //   FormBuilderValidators.max(context, 8, errorText: 'Максимум 8 цифр'),
                                                      // ]),

                                                    ),
                                                    Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваш номер телефона'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),


                                                    FormBuilderTextField(
                                                        name: 'phone2',
                                                        // readOnly: true,
                                                        // enabled: false,
                                                        // initialValue: '${currentUser.phone}',

                                                        //controller: _phoneController,
                                                        cursorWidth: 1.0,
                                                        cursorColor: Colors
                                                            .white,
                                                        style: styleFormInput,
                                                        inputFormatters: [
                                                          maskFormatterPhone
                                                        ],
                                                        decoration: ThemeHelper()
                                                            .textInputDecoration(
                                                            '',
                                                            '',
                                                            ''),
                                                        // onSaved: (value) =>
                                                        // newUser.phone = value!,
                                                        // onChanged: _onChanged,
                                                        // valueTransformer: (text) => num.tryParse(text),
                                                        // autovalidateMode: AutovalidateMode.always,
                                                        // validator: FormBuilderValidators.compose([
                                                        //   FormBuilderValidators.required(context, errorText: 'Поле обязательно для заполнения'),
                                                        //   FormBuilderValidators.numeric(context, errorText: 'Можно вводить только цифры'),
                                                        //   FormBuilderValidators.max(context, 10, errorText: 'Максимум 10 цифр'),
                                                        // ]),
                                                        keyboardType: TextInputType
                                                            .text
                                                    ),
                                                    Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'ваше автомобиль'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),
                                                    FormBuilderTextField(
                                                        name: 'carname',
                                                        cursorWidth: 1.0,
                                                        cursorColor: Colors
                                                            .white,
                                                        style: styleFormInput,
                                                        // decoration: ThemeHelper()
                                                        //     .textInputDecoration(
                                                        //     '',
                                                        //     'Введите название автомобиля',
                                                        //     ''),
                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets
                                                              .all(
                                                              16),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide
                                                                  .none,
                                                              borderRadius: BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                      10))
                                                          ),

                                                          fillColor: Color(
                                                              0XFF515569),
                                                          filled: true,
                                                          hintText: "Введите название автомобиля",
                                                          hintStyle: TextStyle(
                                                            color: Colors
                                                                .white60,
                                                          ),
                                                        ),
                                                        onSaved: (
                                                            value) =>
                                                        carname =
                                                            value,
                                                        // validator: FormBuilderValidators.compose(
                                                        //     [(val) {
                                                        //       if (val == '') {
                                                        //         return null;
                                                        //         // return 'Поле carname не может быть пустым';
                                                        //       }
                                                        //       else if (val == null || val.length < 3) {
                                                        //           return 'Минимум 3 символа';
                                                        //       // } else {
                                                        //       //     return null;
                                                        //       }
                                                        //       return null;
                                                        //       }
                                                        //
                                                        //     ]),
                                                        // onChanged: _onChanged,
                                                        // valueTransformer: (text) => num.tryParse(text),
                                                        //
                                                        keyboardType: TextInputType
                                                            .text
                                                    ),

                                                    Container(
                                                      width: 284,
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Text(
                                                        'загрузите 3 фото вашего cadillac'
                                                            .toUpperCase(),
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: styleTitleFormInput,
                                                      ),
                                                    ),

                                                    // uploadImage(
                                                    //     maxImages: 3),
                                                    FormBuilderImagePicker(
                                                        fit: BoxFit.contain,
                                                        name: 'cars',
                                                        previewHeight: 140,
                                                        previewWidth: 284,
                                                        previewMargin: EdgeInsets.only(bottom: 0),
                                                        iconColor: Colors.white,

                                                        // galleryIcon: SvgPicture.asset(
                                                        //   'assets/images/image2.svg',
                                                        //   // height: 22.0,
                                                        //   height: 10.0,
                                                        //   color: Colors.white,
                                                        // ),

                                                        decoration: const InputDecoration(
                                                          contentPadding: EdgeInsets.all(0),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20)
                                                              )
                                                          ),

                                                          // filled: true,
                                                          // fillColor: Color(0xFF515569),
                                                          // labelText: 'Загрузить фото',
                                                          // labelStyle: stylePlaceHolderText,


                                                        ),
                                                        maxImages: 3,
                                                        onSaved: (
                                                            value) =>
                                                        {
                                                          print('value'),
                                                          print(value.runtimeType),
                                                          cars = value!,

                                                        }
                                                    ),

                                                    Container(
                                                        width: 284,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top: 30,
                                                            bottom: 45),
                                                        child: MaterialButton(
                                                          padding: const EdgeInsets
                                                              .all(
                                                              17),
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          // textColor: const Color(0xFF12141F),
                                                          child: Text(
                                                            "зарегистрироваться"
                                                                .toUpperCase(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF12141F)),
                                                          ),

                                                          shape: const RoundedRectangleBorder(
                                                            side: BorderSide
                                                                .none,
                                                            borderRadius: BorderRadius
                                                                .all(
                                                              Radius
                                                                  .circular(
                                                                  10),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            if (_formKey
                                                                .currentState
                                                                ?.saveAndValidate() ??
                                                                false) {
                                                              // if (true) {
                                                              //   // Either invalidate using Form Key
                                                              //   _formKey
                                                              //       .currentState
                                                              //       ?.invalidateField(
                                                              //       name: 'email',
                                                              //       errorText: 'Email already taken.');
                                                              //   // OR invalidate using Field Key
                                                              //   // _emailFieldKey.currentState?.invalidate('Email already taken.');
                                                              // }

                                                              debugPrint(
                                                                  'Valid success payment admin');


                                                              print(photo[0].path); //путь к картинке в кеше
                                                              print(photo[0].path.runtimeType);
                                                              print(photo[0].path.toString());
                                                              path = await getpathImage(photo[0].path);

                                                              print(cars.length);
                                                              if(cars.length == 2) {
                                                                if(cars[0].path != null) {
                                                                  car1 = await getpathImage(cars[0].path);
                                                                } else {
                                                                  car1 = 'car1';
                                                                }
                                                                if(cars[1].path != null) {
                                                                  car2 = await getpathImage(cars[1].path);
                                                                } else {
                                                                  car2 = 'car2';
                                                                }
                                                                car3 = 'car3';
                                                              } else if (cars.length == 3) {
                                                                if(cars[0].path != null) {
                                                                  car1 = await getpathImage(cars[0].path);
                                                                } else {
                                                                  car1 = 'car1';
                                                                }
                                                                if(cars[1].path != null) {
                                                                  car2 = await getpathImage(cars[1].path);
                                                                } else {
                                                                  car2 = 'car2';
                                                                }
                                                                if(cars[2].path != null) {
                                                                  car3 = await getpathImage(cars[2].path);
                                                                } else {
                                                                  car3 = 'car3';
                                                                }
                                                              } else {
                                                                car1 = await getpathImage(cars[0].path);
                                                                car2 = 'car2';
                                                                car3 = 'car3';
                                                              }




                                                              /*if(cars[1]) {
                                                                            car2 = await getpathImage(cars[1].path);
                                                                          }
                                                                          if(cars[2]) {
                                                                          car3 = await getpathImage(cars[2].path);
                                                                          }
                                                                          print(car1);*/

                                                              print(
                                                                  _formKey
                                                                      .currentState
                                                                      ?.fields
                                                              );

                                                              print(userId);
                                                              //final user = User(email: email, phone :phone);
                                                              dynamic currentUser = User(
                                                                id: '1',
                                                                userId: userId,
                                                                phone: phone,
                                                                email: email,
                                                                username: username,
                                                                birthday: birthday,
                                                                login: login,
                                                                carname: carname,
                                                                // password: password,
                                                                // path: imageName,
                                                                path: path,
                                                                car1: car1,
                                                                car2: car2,
                                                                car3: car3,

                                                              );
                                                              //currentUser = editUser(user);
                                                              // editUser(
                                                              //     currentUser);


                                                              user = await editUser(
                                                                  currentUser);

                                                              print(
                                                                  'after editUser success');
                                                              print('state: $uuid');
                                                              print(user.path);
                                                              print(user.car1);
                                                              print(user.car2);
                                                              print(user.car3);

                                                              //var userId;
                                                              //print(editUser.userId)
                                                              //print(editUser(currentUser));
                                                              //print(editUser(currentUser).userId);

                                                              //print(
                                                              //"editUser: ${editUser.userId}");
                                                              dynamic id = uuid;
                                                              print(
                                                                  "currentId: ${id}");
                                                              userId = uuid;
                                                              // await contactsBox.put(userUuId, currentUser);

                                                              debugPrint(
                                                                  _formKey
                                                                      .currentState
                                                                      ?.value
                                                                      .toString());

                                                              // debugPrint(box.get('phone2').toString());

                                                              Navigator
                                                                  .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          AccountAdmin(userId: userId))
                                                              );
                                                              // Home());

                                                            } else {
                                                              showAlertDialog(context); //не работает почему-то
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
                                                        )
                                                    ),

                                                    Container(
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 0,
                                                          bottom: 30),
                                                      child: GestureDetector(
                                                        onTap: _launchURL,
                                                        // onTap: goToURL,
                                                        child: const Text
                                                            .rich(
                                                          TextSpan(
                                                              text: 'Продолжая вы принимаете ',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight
                                                                      .normal,
                                                                  color: Color(
                                                                      0xFF8F97BF),
                                                                  height: 1.5),
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                  text: 'Пользовательское соглашение и конфиденциальность',
                                                                  style: TextStyle(
                                                                    decoration: TextDecoration
                                                                        .underline,
                                                                    decorationThickness: 2,),
                                                                )
                                                              ]
                                                          ),
                                                        ),

                                                      ),
                                                    ),

                                                  ]
                                              )




                                              //]
                                            )
                                          ]
                                      )
                                  )

                              )
                            ]
                        )
                    ),

                  )
                ]
            ),

          ),

          drawer: NavDrawer(),
        )
    );
  }
  getpathImage(url) async {
    return url;
  }

  // Future<String> editUser() async {
  editUser(User user) async {
    print('func editUser success');
    //print('user.userId');
    //print(userId);
    print(user.path);
    dynamic login = user.login;
    // dynamic password  = user.password;
    // dynamic photo = user.photo;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    dynamic carname = user.carname;
    dynamic path = user.path;
    dynamic car1, car2, car3;
    if(user.car1 != 'null') car1 = user.car1;
    if(user.car2 != 'null') car2 = user.car2;
    if(user.car3 != 'null') car3 = user.car3;
    print(car1);
    print('uuid: $uuid'); //null
    print(user.userId); //null

//   var dio = Dio();
//   List<Cookie> cookies = [
//     new Cookie("uuid", uuid)
//   ];
//
//
//   var cookieJar = PersistCookieJar();
//   dio.interceptors.add(CookieManager(cookieJar));
//   //Save cookies
//   cookieJar.saveFromResponse(Uri.parse(baseUrl), cookies);
//
// //Get cookies
//   cookieJar.loadForRequest(Uri.parse(baseUrl));
//   print('get cookie');
//   //print(cookieJar.loadForRequest(Uri.parse(baseUrl)));
// //
// //   //print(cookies);
//     dynamic result = await dio.get(baseUrl);
// print(result);

    // print(cookieJar);
    //
    // dio.interceptors.add(CookieManager(cookieJar));
    // dynamic result = await dio.get("http://localhost");
    // // Print cookies
    // print(cookieJar.loadForRequest(Uri.parse("http://localhost")));
    // // second request with the cookie
    // await dio.get("http://localhost");



    String apiurl = baseUrl + "/test/edit.php";
    // String apiurl = "http://localhost/test/edit.php";
    var response = await http.post(Uri.parse(apiurl),
        body:{'userId': uuid,'login': login, 'username': username, 'birthday': birthday, 'carname': carname, 'path': path, 'car1': car1,'car2': car2,'car3': car3,},
        headers: {'Accept':'application/json, charset=utf-8',
          "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});

    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}, body:{'phone': phone,'email': email});
    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
    //       "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
    print('after response success');
    // print("response.body success: ${jsonDecode(response.body)}");  SyntaxError: Unexpected end of JSON input


    // print(User.fromJson(jsonDecode(response.body)));
    if(response.statusCode == 200){
      print('success success-payment');



      var cookie = response.headers['set-cookie'];
      print('cookie: $cookie'); //null
      print(path);
      // var uuid = const Uuid();
      // id = uuid.v1();
      print(response.body);
      //return response.body; //это правильно

      final userJson = json.decode(response.body);
      //final userJson = response.body;
      print('userJson success');
      print(userJson);
      var data = User.fromJson(userJson);
      print('data.userId');
      print(data.userId);
      // setState(() {
      //   uuid = data.userId;
      // });
      if (mounted && userId != null) {
        setState(() {
          uuid = data.userId;
        });
      }
      //getCookie(data.userId);
      //return(data);
      return User.fromJson(userJson);

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

getCookie(cookie) async {
  print('get cookie');
  var dio = Dio();
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
  // print(cookieJar.loadForRequest(Uri.parse(baseUrl)));

  //print(cookies);
  // await dio.get(baseUrl);
}



void _onChanged() {}

final Uri _url = Uri.parse('https://www.google.com');

void _launchURL() async {

  if (!await launchUrl(_url)) throw 'Could not launch $_url';
  // const url = 'https://www.google.com';  //наша ссылка
  // if (await canLaunchUrl(url)) {  //проверяем наличие браузера на устройстве
  //   await launchUrl(url, forceWebView: true);   //true если открываем в приложении, false открываем в браузере
  // } else {
  //   throw 'Could not launch $url';
}

showAlertDialog(BuildContext context) {

  AlertDialog alert = AlertDialog(
    //title: Text("Simple Alert"),
    content: Text('Вы заполнилил не все поля формы'.toUpperCase(),
      textAlign: TextAlign.center,
      style: styleTextAlertDialog,
    ),
    actions: <Widget>[
      Container (
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(14),
                  color: Color(0xFFE4E6FF),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),),
                  child: Text(
                    'Ок'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: styleTextAlertDialog,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

              ]
          )
      )


    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

