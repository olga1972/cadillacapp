import 'dart:ui';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/widgets/uploadImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'generated/l10n.dart';

// import 'package:hive/hive.dart';
// import 'package:requests/requests.dart';

// import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid_util.dart';



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

import 'contacts.dart';
import 'members.dart';
import 'news.dart';

class SuccessPayment extends StatelessWidget {
  //var currentUser;
  //final User currentUser;
  //final User userId;

  // SuccessPayment({Key? key, required this.currentUser,} ) : super(key: key);
  SuccessPayment({Key? key,} ) : super(key: key);

  //final String userUuId;
  //late final dynamic currentUser;

  final _formKey = GlobalKey<FormBuilderState>();
  //final List<String>? _allowedExtensions = ['png', 'pdf'];

  late dynamic userId = "111";
  late dynamic login = "test@mail.ru";
  late dynamic username;
  late dynamic email = 'test@test';
  late dynamic phone = '5555';
  late dynamic password;
  late dynamic birthday;
  late dynamic type;
  late dynamic car;
  // late final dynamic token = '12345678';
  // late final dynamic renewalToken = '12345678';
  // late final dynamic photo = new ApiImage(imageUrl: 'assets/images/avatar.png', id: '1');
  late final dynamic photo = ('assets/images/avatar.png');
  // late final dynamic cars = new ApiImage (
  //     imageUrl: 'assets/images/cadillac-eldorado.png', id: '2');
  // late final cars = Cars ();

  // final User userInfo;

  // var box = Hive.box<User>(HiveBoxes.user);


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
    // debugPrint(box.values.length);

    //User currentUser = User();
//dynamic currentUser;

    // currentUser = editUser();

    // print('after');
    print('load');
    // print(userId);
    // print(this.currentUser);
    // print('after2');


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
                                                bottom: 58),
                                            child: const TitlePage(
                                                title: 'успешная оплата!'),
                                          ),

                                          Container(
                                            width: 284,
                                            margin: const EdgeInsets.only(
                                                bottom: 56),
                                            child: Text(
                                              'введите логин и пароль, \nотправленные на ваш email'
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: styleTitleFormInput,
                                            ),
                                          ),
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
                                                                .text,
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
                                                              .only(top: 30,
                                                              bottom: 10),
                                                        ),


                                                        Accordion(
                                                            content: SizedBox(
                                                                width: 284,

                                                                child: Column(
                                                                    children: [
                                                                      Container(

                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            top: 53,
                                                                            bottom: 40),
                                                                        child: const TitlePage(
                                                                            title:
                                                                            'регистрация члена \nавтоклуба cadillac'),
                                                                      ),

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

                                                                        child: uploadImage(
                                                                            maxImages: 1),

                                                                        // child: FormBuilderImagePicker(
                                                                        //   name: 'photo',
                                                                        //   // previewHeight: 96,
                                                                        //   // previewWidth: 96,
                                                                        //   // previewMargin: EdgeInsets.symmetric(horizontal: 150),
                                                                        //   previewHeight: 140,
                                                                        //   previewWidth: 284,
                                                                        //   previewMargin: EdgeInsets.only(bottom: 0),
                                                                        //   iconColor: Colors.white,
                                                                        //   decoration: const InputDecoration(
                                                                        //     border: OutlineInputBorder(
                                                                        //         borderSide: BorderSide.none,
                                                                        //         borderRadius: BorderRadius.all(
                                                                        //             Radius.circular(20)
                                                                        //         )
                                                                        //     ),
                                                                        //
                                                                        //     // labelText: 'Загрузить фото',
                                                                        //     // labelStyle: styleHelperText,
                                                                        //   ),
                                                                        //   maxImages: 1,
                                                                        //   displayCustomType: (obj) =>
                                                                        //   obj is ApiImage ? obj.imageUrl : obj,
                                                                        //   initialValue: [
                                                                        //     'https://images.pexels.com/photos/7078045/pexels-photo-7078045.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                                                                        //     const Text('this is an image\nas a widget !'),
                                                                        //     ApiImage(
                                                                        //       id: 'whatever',
                                                                        //       imageUrl:
                                                                        //       'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                                                        //     ),
                                                                        //   ],
                                                                        //
                                                                        // ),

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
                                                                          name: 'car',
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
                                                                          car =
                                                                          value!,
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

                                                                      uploadImage(
                                                                          maxImages: 3),
                                                                      // FormBuilderImagePicker(
                                                                      //   // fit: BoxFit.contain,
                                                                      //   name: 'cars',
                                                                      //   previewHeight: 140,
                                                                      //   previewWidth: 284,
                                                                      //   previewMargin: EdgeInsets.only(bottom: 0),
                                                                      //   iconColor: Colors.white,
                                                                      //
                                                                      //   // galleryIcon: SvgPicture.network(
                                                                      //   //   'assets/images/image2.svg',
                                                                      //   //   // height: 22.0,
                                                                      //   //   height: 10.0,
                                                                      //   //   color: Colors.white,
                                                                      //   // ),
                                                                      //
                                                                      //
                                                                      //   decoration: const InputDecoration(
                                                                      //     contentPadding: EdgeInsets.all(0),
                                                                      //     border: OutlineInputBorder(
                                                                      //         borderSide: BorderSide.none,
                                                                      //         borderRadius: BorderRadius.all(
                                                                      //             Radius.circular(20)
                                                                      //         )
                                                                      //     ),
                                                                      //
                                                                      //     // filled: true,
                                                                      //     // fillColor: Color(0xFF515569),
                                                                      //     // labelText: 'Загрузить фото',
                                                                      //     // labelStyle: stylePlaceHolderText,
                                                                      //
                                                                      //
                                                                      //   ),
                                                                      //   maxImages: 3,
                                                                      //   displayCustomType: (obj) =>
                                                                      //   obj is ApiImage ? obj.imageUrl : obj,
                                                                      //   initialValue: [
                                                                      //     'https://images.pexels.com/photos/7078045/pexels-photo-7078045.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                                                                      //     const Text('this is an image\nas a widget !'),
                                                                      //     ApiImage(
                                                                      //       id: 'whatever',
                                                                      //       imageUrl:
                                                                      //       'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                                                      //     ),
                                                                      //   ],
                                                                      // ),

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
                                                                                    'Valid success payment');
                                                                                print(
                                                                                    userId);
                                                                                print(
                                                                                    _formKey
                                                                                        .currentState
                                                                                        ?.fields
                                                                                        .values
                                                                                );
                                                                                //photo =new ApiImage();
                                                                                //final user = User(email: email, phone :phone);
                                                                                dynamic currentUser = User(
                                                                                  id: 1,
                                                                                  userId: userId,
                                                                                  phone: phone,
                                                                                  email: email,
                                                                                  username: username,
                                                                                  birthday: birthday,
                                                                                  login: login,
                                                                                  // password: password,
                                                                                  // photo: photo,

                                                                                  // car: car,

                                                                                  // cars: (cars),

                                                                                );
                                                                                //currentUser = editUser(user);
                                                                                editUser(
                                                                                    currentUser);
                                                                                print(
                                                                                    'after editUser');
                                                                                print(
                                                                                    'user success');

                                                                                print(
                                                                                    "currentUser: ${currentUser
                                                                                        .email}");
                                                                                // var id = currentUser
                                                                                //     .userId;
                                                                                // print(
                                                                                //     "currentId: ${id}");
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
                                                                                            Account()
                                                                                    ));
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
                                                            )

                                                        )

                                                      ]
                                                  )
                                              )
                                          )
                                        ]
                                    )
                                )
                            ),


                          ]
                      ),

            ),
            drawer: NavDrawer(),
        )
    );
  }


  // Future<String> editUser() async {
    editUser(User user) async {
    print('func editUser success');
    // print(user.login);
    dynamic login = user.login;
    // dynamic password  = user.password;
    // dynamic photo = user.photo;
    dynamic username = user.username;
    dynamic birthday = user.birthday;
    // dynamic car = user.car;
    // dynamic cars = user.cars;


    String apiurl = "http://localhost/test/edit.php";
    var response = await http.post(Uri.parse(apiurl), body:{'login': login, 'username': username, 'birthday': birthday, },headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});

    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"}, body:{'phone': phone,'email': email});
    // var response = await http.post(Uri.parse(apiurl), headers: {'Accept':'application/json',"Access-Control-Allow-Origin": "*",
    //       "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});
    print('after response');
    // print("response.body success: ${jsonDecode(response.body)}");  SyntaxError: Unexpected end of JSON input


    // print(User.fromJson(jsonDecode(response.body)));
    if(response.statusCode == 200){
      print('success success-payment');
      // var uuid = const Uuid();
      // id = uuid.v1();
      print(response.body);
      //return response.body; //это правильно

      final userJson = json.decode(response.body);
      //final userJson = response.body;
      print('userJson success');
      print(userJson);
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

