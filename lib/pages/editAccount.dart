import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/pages/account.dart';

import 'package:cadillac/models/users.dart' as my_user;
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import 'data.dart';

enum ImageSourceType { gallery, camera }

// var uuid = '';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  final String path = '';

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late String encode64;
  late String errorMessage;

  dynamic currentUser;
  dynamic findingUser;

  @override
  initState() {
    debugPrint('init state edit');
    super.initState();
    // uuid = '';
    encode64 = '';
    final String? uid = user?.uid;
    debugPrint(uid);
    userId = uid;
    print('userId');
    print(userId);
    currentUser = getUser(userId, context);
    errorMessage = '';
  }

  final _formKey = GlobalKey<FormBuilderState>();
  late dynamic userId;
  late dynamic username;
  late dynamic email = 'test@test';
  late dynamic phone = '5555';
  late dynamic password;
  late dynamic login = 'test@test';
  late dynamic birthday;
  late dynamic type;
  late dynamic carname;
  late String path = "assets/images/avatar.png";
  late dynamic car1;
  late dynamic car2;
  late dynamic car3;

  late List<dynamic> photo;
  late List<dynamic> cars;

  late String platform;
  late Uint8List? bytes;
  late Uint8List? bytesCar1;
  late Uint8List? bytesCar2;
  late Uint8List? bytesCar3;

  late String fieldOfActivity;
  late String numberCar;
  late String yearIssue;
  late String status;
  late String numberCard;

  var maskFormatterPhone = MaskTextInputFormatter(mask: '+7 ___-___-__-__', filter: {"_": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  var maskFormatterDate = MaskTextInputFormatter(mask: '__.__.____', filter: {"_": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  User? user = FirebaseAuth.instance.currentUser;



  @override
  Widget build(BuildContext context) {
    debugPrint('load edit account');

    // platform = Provider.of<Data>(context).data['platform'].toString();
    // debugPrint(platform);
    return ChangeNotifierProvider<Data> (
        create: (context) => Data(),
    builder: (context, child) {
    // final String? uid = user?.uid;
    // debugPrint(uid);
    // userId = uid;
    //
    // currentUser = getUser(userId, context);
    // userId = Provider.of<Data>(context).data['userId'].toString();
    // platform = Provider.of<Data>(context).data['platform'].toString();
    // debugPrint(platform);
    // debugPrint(userId);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
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
                              Account()));
                    },
                  );
                },
              ),
            ),
            body: FutureBuilder<my_user.User>(
                //return FutureBuilder<User>(
                future: currentUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.hasData) {
                    debugPrint('snapshot.data?.numberCard');
                    debugPrint(snapshot.data?.numberCard);

                    platform = Provider.of<Data>(context).data['platform'].toString();
                    return SafeArea(
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Container(
                              width: 284,
                              margin: const EdgeInsets.only(top: 10, bottom: 47),
                            ),
                            Container(
                              width: 284,
                              margin: const EdgeInsets.only(bottom: 58),
                              child: const TitlePage(title: 'изменение данных'),
                            ),
                                    Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(top: 30, bottom: 45),
                                        child: errorMessage != '' ? Text(errorMessage,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'CadillacSans',
                                                color: Colors.white,
                                                height: 1.4 //line-height : font-size
                                            ),
                                            textAlign: TextAlign.center)
                                            : null
                                    ),
                            Container(
                                width: 284,
                                margin: const EdgeInsets.only(bottom: 56),
                                child: FormBuilder(
                                    key: _formKey,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          'мой логин'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),
                                      FormBuilderTextField(
                                          name: 'login',
                                          initialValue: snapshot.data?.email,
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
                                          'мой пароль'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),
                                      FormBuilderTextField(
                                          name: 'password',
                                          initialValue: snapshot.data?.password,
                                          cursorWidth: 1.0,
                                          // autofocus: true,
                                          enabled: false,
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
                                              } else if (val.length < 6) {
                                                // return 'Invalid email address';
                                                return 'Минимум 6 символов';
                                              } else {
                                                return null;
                                              }
                                            }
                                          ]),
                                          onSaved: (value) => password = value!),
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                                      ),
                                      SizedBox(
                                          width: 284,
                                          child: Column(children: [
                                            Container(
                                              width: 284,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'мое фото'.toUpperCase(),
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
                                                  typeSelectors: [
                                                    TypeSelector(
                                                      type: FileType.any,
                                                      selector:
                                                      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                        Stack(alignment: Alignment.center, children: [
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: 96,
                                                            height: 96,
                                                            decoration:
                                                            const BoxDecoration(color: Color(0xFF515569), borderRadius: BorderRadius.all(Radius.circular(48))),
                                                          ),
                                                          SvgPicture.asset(
                                                            'assets/images/image.svg',
                                                            semanticsLabel: 'Icon upload',
                                                            height: 18.0,
                                                          ),
                                                        ]),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: const [
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

                                                    ),

                                                  ],
                                                  onFileLoading: (val) {
                                                    // debugPrint(val);
                                                  },
                                                  onSaved: (value) => {
                                                        debugPrint('value'),
                                                        debugPrint(value.runtimeType.toString()),
                                                        photo = value!,
                                                      }),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'мои имя и фамилия'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'username',
                                                initialValue: snapshot.data?.username,
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
                                                'моя дата рождения'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                              name: 'birthday',
                                              initialValue: snapshot.data?.birthday,
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
                                                'мой номер телефона'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'phone2',
                                                initialValue: snapshot.data?.phone,
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
                                                'мой статус'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'status',
                                                initialValue: '${snapshot.data?.status}',
                                                cursorWidth: 1.0,
                                                enabled: false,
                                                cursorColor: Colors.white,
                                                style: styleFormInput,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                autovalidateMode: AutovalidateMode.always,
                                                validator: FormBuilderValidators.compose([
                                                      (val) {
                                                    if (val == null) {
                                                      return 'Поле status не может быть пустым';
                                                    } else if (val.length < 6) {
                                                      // return 'Invalid email address';
                                                      return 'Минимум 6 символов';
                                                    } else {
                                                      return null;
                                                    }
                                                  }
                                                ]),
                                                onSaved: (value) => status = value!),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'моя карта привелегий'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'numberCard',
                                                initialValue: '${snapshot.data?.numberCard}',
                                                cursorWidth: 1.0,
                                                enabled: false,
                                                cursorColor: Colors.white,
                                                style: styleFormInput,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                autovalidateMode: AutovalidateMode.always,
                                                validator: FormBuilderValidators.compose([
                                                      (val) {
                                                    if (val == null) {
                                                      return 'Поле numberCard не может быть пустым';
                                                    } else if (val.length < 1) {
                                                      // return 'Invalid email address';
                                                      return 'Минимум 1 символов';
                                                    } else {
                                                      return null;
                                                    }
                                                  }
                                                ]),
                                                onSaved: (value) => numberCard = value!),
                                            Container(
                                              width: 284,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'сфера деятельности'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'fieldOfActivity',
                                                initialValue: snapshot.data?.yearIssue,
                                                cursorWidth: 1.0,
                                                cursorColor: Colors.white,
                                                style: styleFormInput,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "Введите сферу деятельности",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                onSaved: (value) => fieldOfActivity = value!,
                                                keyboardType: TextInputType.text),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'мой автомобиль'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'carname',
                                                initialValue: snapshot.data?.carname,
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
                                                onSaved: (value) => carname = value!,
                                                keyboardType: TextInputType.text),
                                            Container(
                                              width: 284,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'номер автомобиля'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'numberCar',
                                                initialValue: snapshot.data?.numberCar,
                                                cursorWidth: 1.0,
                                                cursorColor: Colors.white,
                                                style: styleFormInput,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "Введите гос. номер автомобиля",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                onSaved: (value) => numberCar = value!,
                                                keyboardType: TextInputType.text),
                                            Container(
                                              width: 284,
                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: Text(
                                                'год выпуска автомобиля'.toUpperCase(),
                                                textAlign: TextAlign.left,
                                                style: styleTitleFormInput,
                                              ),
                                            ),
                                            FormBuilderTextField(
                                                name: 'yearIssue',
                                                initialValue: snapshot.data?.yearIssue,
                                                cursorWidth: 1.0,
                                                cursorColor: Colors.white,
                                                style: styleFormInput,
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  fillColor: Color(0XFF515569),
                                                  filled: true,
                                                  hintText: "Введите год выпуска авто",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                onSaved: (value) => yearIssue = value!,
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
                                                typeSelectors: [
                                                  TypeSelector(
                                                    type: FileType.any,
                                                    selector: Column(children: [
                                                      Stack(alignment: Alignment.center, children: [
                                                        Container(
                                                          width: 284,
                                                          height: 160,
                                                          decoration: const BoxDecoration(
                                                              color: Color(0xFF515569),
                                                              shape: BoxShape.rectangle,
                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                                  ),

                                                ],
                                                onFileLoading: (val) {
                                                  // debugPrint(val);
                                                },
                                                onSaved: (value) => {
                                                      debugPrint('value'),
                                                      debugPrint(value.runtimeType.toString()),
                                                      cars = value!,
                                                    }),
                                            Container(
                                                width: 284,
                                                margin: const EdgeInsets.only(top: 30, bottom: 45),
                                                child: MaterialButton(
                                                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 21),
                                                  color: const Color.fromARGB(255, 255, 255, 255),
                                                  child: Text(
                                                    "сохранить".toUpperCase(),
                                                    style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                                  ),
                                                  shape: const RoundedRectangleBorder(
                                                    side: BorderSide.none,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    confirmDialog(context);
                                                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                                                      debugPrint('Valid success edit admin');
                                                      // Provider.of<Data>(context, listen: false).updateAccount(2);

                                                      if (platform == 'android' || platform == 'ios') {
                                                        debugPrint(platform);
                                                        final bytes = photo[0].bytes; //для сборки приложения под мобильный браузер

                                                        //final bytes = File(photo[0].path).readAsBytesSync(); //для сборки приложения под андроид
                                                        setState(() {
                                                          encode64 = base64.encode(bytes);
                                                        });

                                                        debugPrint('cars.length');
                                                        debugPrint(cars.length.toString());
                                                        if (cars.length == 2) {
                                                          if (cars[0].path != null) {
                                                            final bytesCar1 = cars[0].bytes;
                                                            // final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                            car1 = base64.encode(bytesCar1);
                                                          } else {
                                                            car1 = '';
                                                          }
                                                          if (cars[1].path != null) {
                                                            final bytesCar2 = cars[1].bytes;
                                                            // final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                            car2 = base64.encode(bytesCar2);
                                                          } else {
                                                            car2 = '';
                                                          }
                                                          car3 = '';
                                                        } else if (cars.length == 3) {
                                                          if (cars[0].path != null) {
                                                            final bytesCar1 = cars[0].bytes;
                                                            // final bytesCar1 = File(cars[0].path).readAsBytesSync();
                                                            car1 = base64.encode(bytesCar1);
                                                          } else {
                                                            car1 = '';
                                                          }
                                                          if (cars[1].path != null) {
                                                            final bytesCar2 = cars[1].bytes;
                                                            // final bytesCar2 = File(cars[1].path).readAsBytesSync();
                                                            car2 = base64.encode(bytesCar2);
                                                          } else {
                                                            car2 = '';
                                                          }
                                                          if (cars[2].path != null) {
                                                            final bytesCar3 = cars[2].bytes;
                                                            // final bytesCar3 = File(cars[2].path).readAsBytesSync();
                                                            car3 = base64.encode(bytesCar3);
                                                          } else {
                                                            car3 = '';
                                                          }
                                                        } else {
                                                          final bytesCar1 = cars[0].bytes;
                                                          // final bytesCar1 = File(cars[0].path).readAsBytesSync();
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


                                                        try {
                                                          bytes = photo[0].bytes;
                                                          setState(() {
                                                            encode64 = base64.encode(bytes!);
                                                          });
                                                        } catch (error, stack) {
                                                          setState(() {
                                                            errorMessage = 'Error: $error, stack: $stack';
                                                          });

                                                          throw Exception('Error: $error, stack: $stack');
                                                        }
                                                        // setState(() {
                                                        //   encode64 = base64.encode(bytes!);
                                                        // });
                                                      }

                                                      debugPrint(userId);

                                                      dynamic currentUser = my_user.User(
                                                          id: '1',
                                                          userId: userId,
                                                          login: login,
                                                          password: password,
                                                          username: username,
                                                          birthday: birthday,
                                                          carname: carname,
                                                          phone: phone,
                                                          email: email,
                                                          path: encode64,
                                                          car1: car1,
                                                          car2: car2,
                                                          car3: car3,
                                                          dateRegister: 'dateRegister',
                                                          dateExpired: 'dateExpired',
                                                          fieldOfActivity: fieldOfActivity,
                                                          numberCar: numberCar,
                                                          yearIssue: yearIssue,
                                                          numberCard: numberCard,
                                                          status: status
                                                      );

                                                      findingUser = await getUserByEmail(currentUser);

                                                      user = await editUser(currentUser);
                                                      debugPrint('after editUser');
                                                    } else {
                                                      debugPrint('Invalid');
                                                    }
                                                  },
                                                )),
                                          ]))
                                    ])))
                          ]))),
                        ]),
                      ),
                    );
                  }
                  return const Center(child: Text('no data'));
                }),
            drawer: const NavDrawer()));});
  }
}

getPathImage(url) async {
  return url;
}

Future<my_user.User> getUser(userId, context) async {
  debugPrint('getUser');
  debugPrint('userId: $userId');

  String apiUrl = baseUrl + "/test/get_user.php";

  final response = await http.post(Uri.parse(apiUrl), body: {
    'userId': userId
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "http://localhost:59369",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  if (response.statusCode == 200) {
    final userJson = json.decode(response.body);

    //checkAccount(my_user.User.fromJson(userJson).dateExpired, context);

    var data = my_user.User.fromJson(userJson);
    debugPrint(data.numberCard);

    return (data);
  } else {
    throw Exception('Error fetching users');
  }
}

getUserByEmail(my_user.User user) async {
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
  dynamic fieldOfActivity = user.fieldOfActivity;
  dynamic numberCar = user.numberCar;
  dynamic yearIssue = user.yearIssue;
  dynamic status = user.status;
  dynamic numberCard = user.numberCard;

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
    'password': password,
    'fieldOfActivity': fieldOfActivity,
    'numberCar': numberCar,
    'yearIssue': yearIssue,
    'status': status,
    'numberCard': numberCard
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  if (response.statusCode == 200) {
    debugPrint('success getUserByEmail');
    debugPrint(response.body);
    /*try {
      final userJson = json.decode(response.body);

    } catch (error, stack) {

        debugPrint('Error: $error, stack: $stack');

      throw Exception('Error: $error, stack: $stack');
    }*/

    final userJson = json.decode(response.body);
    var data = my_user.User.fromJson(userJson);

    // Provider.of<Data>(context, listen: false).updateUserId(data.userId);
    // debugPrint('data.userId');
    return (data);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

editUser(my_user.User user) async {
  debugPrint('func editUser edit');
  dynamic userId = user.userId;
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
  dynamic fieldOfActivity = user.fieldOfActivity;
  dynamic numberCar = user.numberCar;
  dynamic yearIssue = user.yearIssue;
  dynamic status = user.status;
  dynamic numberCard = user.numberCard;

  String apiUrl = baseUrl + "/test/edit.php";
  var response = await http.post(Uri.parse(apiUrl), body: {
    'userId': userId,
    'login': login,
    'username': username,
    'birthday': birthday,
    'carname': carname,
    'path': path,
    'car1': car1 != '' ? car1 : '',
    'car2': car2 != '' ? car2 : '',
    'car3': car3 != '' ? car3 : '',
    'password': password,
    'fieldOfActivity': fieldOfActivity,
    'numberCar': numberCar,
    'yearIssue': yearIssue,
    'status': status,
    'numberCard': numberCard,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });
  debugPrint('after response edit');

  if (response.statusCode == 200) {
    debugPrint('success edit');
    debugPrint(response.body);
    final userJson = json.decode(response.body);
    var data = my_user.User.fromJson(userJson);
    return data;
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
          'Изменить данные?'.toUpperCase(),
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
                  onPressed: () async {
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Account()));
                  },
                )
              ]))
        ],
      );
    },
  );
}
