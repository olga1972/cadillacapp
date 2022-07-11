// import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';


import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../models/news.dart';
import '../main.dart';
import 'newsAdmin.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  late String encode64News;

  @override
  void initState() {
    super.initState();
    encode64News = '';
  }
  final _newsKey = GlobalKey<FormBuilderState>();

  // get currentUser => null;
  late dynamic news;

  late String id = '1';
  late String newsId = '111';
  late String newsName = 'name';
  late String newsDate = 'date';
  late String newsLocation = 'location';
  late String newsDescr = 'descr';
  late String path;

  late List<dynamic> newsImage;
  late String platform;
  late Uint8List? bytes;
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
    platform = Provider.of<Data>(context).data['platform'].toString();
    print(platform);

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

          body: Center (
            child: Container (
              width: 284,
              margin: const EdgeInsets.only(top: 70),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded (
                    child: SingleChildScrollView (
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 284,
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: const TitlePage(title: 'добавить новость'),
                                ),

                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FormBuilder(
                                          key: _newsKey,
                                          autovalidateMode: AutovalidateMode.always,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  //alignment: Alignment(-1,0),
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    'заголовок новости'.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: styleTitleFormInput,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 284,
                                                  child: FormBuilderTextField(
                                                      name: 'newsName',
                                                      autofocus: true,
                                                      cursorWidth: 1.0,
                                                      cursorColor: Colors.white,
                                                      style: styleFormInput,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        fillColor: Color(0XFF515569),
                                                        filled: true,
                                                        hintText: "заголовок новости",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,
                                                      onSaved: (value) => newsName = value!,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: FormBuilderValidators.compose([
                                                      //   // FormBuilderValidators.required(context),
                                                      //   // FormBuilderValidators.numeric(context),
                                                      //   // FormBuilderValidators.max(context, 70),
                                                      // ]),
                                                      autovalidateMode: AutovalidateMode.always,

                                                  validator:
                                                      FormBuilderValidators.compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return 'Поле newsName не может быть пустым';
                                                          } else if (val.length < 3) {
                                                            return 'Минимум 3 символа';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ]),
                                                      keyboardType: TextInputType.text),
                                                ),

                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    'дата проведения'.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: styleTitleFormInput,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 284,
                                                  child: FormBuilderTextField(
                                                      name: 'newsDate',
                                                      autofocus: true,
                                                      style: styleFormInput,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        fillColor: Color(0XFF515569),
                                                        filled: true,
                                                        hintText: "дата проведения",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,
                                                      onSaved: (value) => newsDate = value!,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: FormBuilderValidators.compose([
                                                      //   // FormBuilderValidators.required(context),
                                                      //   // FormBuilderValidators.numeric(context),
                                                      //   // FormBuilderValidators.max(context, 70),
                                                      // ]),
                                                      validator:
                                                      FormBuilderValidators.compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return 'Поле newsDate не может быть пустым';
                                                          } else if (val.length < 3) {
                                                            return 'Минимум 3 символа';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ]),
                                                      keyboardType: TextInputType.text),
                                                ),
                                                SizedBox(
                                                  width: 284,
                                                  child: Container(
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: Text(
                                                      'место проведения'.toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: styleTitleFormInput,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 284,
                                                  child: FormBuilderTextField(
                                                      name: 'newsLocation',
                                                      autofocus: true,
                                                      style: styleFormInput,
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.all(16),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        fillColor: Color(0XFF515569),
                                                        filled: true,
                                                        hintText: "место проведения",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,
                                                      onSaved: (value) => newsLocation = value!,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: FormBuilderValidators.compose([
                                                      //   // FormBuilderValidators.required(context),
                                                      //   // FormBuilderValidators.numeric(context),
                                                      //   // FormBuilderValidators.max(context, 70),
                                                      // ]),
                                                      validator:
                                                      FormBuilderValidators.compose([
                                                            (val) {
                                                          if (val == null) {
                                                            return 'Поле newsLocation не может быть пустым';
                                                          } else if (val.length < 3) {
                                                            return 'Минимум 3 символа';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ]),
                                                      keyboardType: TextInputType.text),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 17, bottom: 10),
                                                  child: Text(
                                                    'описание'.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: styleTitleFormInput,
                                                  ),
                                                ),
                                                FormBuilderTextField(
                                                  name: 'newsDescr',
                                                  autofocus: true,
                                                  style: styleFormInput,
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.all(16),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                    fillColor: Color(0XFF515569),
                                                    filled: true,
                                                    hintText: "Введите описание",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  // onChanged: _onChanged,
                                                  onSaved: (value) =>  newsDescr = value!,
                                                  // valueTransformer: (text) => num.tryParse(text),
                                                  // validator: FormBuilderValidators.compose([
                                                  //   // FormBuilderValidators.required(context),
                                                  //   // FormBuilderValidators.numeric(context),
                                                  //   // FormBuilderValidators.max(context, 70),
                                                  // ]),
                                                  validator: FormBuilderValidators.compose([
                                                        (val) {
                                                      if (val == null) {
                                                        return 'Поле newsDescr не может быть пустым';
                                                      } else if (val.length < 5) {
                                                        // return 'Invalid email address';
                                                        return 'Минимум 5 символа';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  ]
                                                  ),
                                                  minLines:
                                                  6, // any number you need (It works as the rows for the textarea)
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: null,
                                                ),

                                                SizedBox(
                                                  height: 20
                                                ),

                                                FormBuilderFilePicker(
                                                    name: "newsImage",
                                                    decoration:
                                                    InputDecoration(
                                                      fillColor:
                                                      Color(0xff515569),
                                                      iconColor: Colors.white,
                                                      contentPadding:
                                                      EdgeInsets.all(0),
                                                      border:
                                                      OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                        //gapPadding: 40,
                                                      ),
                                                    ),
                                                    maxFiles: null,
                                                    previewImages: true,
                                                    onChanged: (val) => {},
                                                    selector: Column(
                                                        children: [
                                                          Stack(
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              children: [
                                                                Container(
                                                                  //dding: EdgeInsets.only(bottom: 40),
                                                                  width: 284,
                                                                  height: 160,
                                                                  decoration: const BoxDecoration(
                                                                      color: Color(
                                                                          0xFF515569),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      borderRadius:
                                                                      BorderRadius.all(Radius.circular(10))),
                                                                ),
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/images/load.svg',
                                                                  semanticsLabel:
                                                                  'Icon upload',
                                                                  height:
                                                                  18.0,
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      children: [
                                                                        SizedBox(
                                                                            height: 40),
                                                                        Text(
                                                                            'Загрузить фото',
                                                                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'CadillacSans', color: Colors.white, height: 1.4 //line-height : font-size
                                                                            ),
                                                                            textAlign: TextAlign.center),
                                                                        Icon(
                                                                          Icons.file_upload,
                                                                          semanticLabel:
                                                                          'Icon upload',
                                                                          size:
                                                                          18.0,
                                                                          color:
                                                                          Colors.white,
                                                                        )
                                                                      ]),
                                                                )
                                                              ]),
                                                        ]),
                                                    onFileLoading: (val) {
                                                      // print(val);
                                                    },
                                                    onSaved: (value) => {
                                                      print('value'),
                                                      print(value
                                                          .runtimeType),
                                                      newsImage = value!,
                                                    }),

                                            //]
                                          //),


                                          Container(
                                            width: 284,
                                            margin: const EdgeInsets.only(top: 30, bottom: 45),
                                            child: MaterialButton(
                                              padding: const EdgeInsets.all(17),
                                              color: const Color.fromARGB(255, 255, 255, 255),
                                              // textColor: const Color(0xFF12141F),
                                              child: Text(
                                                "Создать".toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 14, color: Color(0xFF12141F)),
                                              ),

                                              shape: const RoundedRectangleBorder(
                                                side: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {

                                                if (_newsKey.currentState?.saveAndValidate() ??
                                                    false) {
                                                  confirmDialog(context);
                                                  debugPrint('News added');
                                                  if (platform == 'android' ||
                                                      platform == 'ios') {
                                                    print(platform);
                                                    final bytes = File(newsImage[0].path).readAsBytesSync();
                                                    print(bytes);
                                                    print(bytes.runtimeType);
                                                    setState(() {
                                                      encode64News = base64.encode(bytes);
                                                    });
                                                    //var encode64 = base64.encode(bytes);
                                                    print(encode64News);


                                                  } else {
                                                    print(platform);
                                                    //late Uint8List bytes;
                                                    bytes = newsImage[0].bytes;

                                                    setState(() {
                                                      encode64News = base64.encode(bytes!);
                                                    });
                                                  }
                                                  final news = New(
                                                    id: id,
                                                    newsId: newsId,
                                                    newsName: newsName,
                                                    newsDate: newsDate,
                                                    newsLocation: newsLocation,
                                                    newsDescr: newsDescr,
                                                    path: encode64News
                                                  );

                                                  addNews(news);

                                                  Navigator
                                                      .pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (
                                                              context) =>
                                                              const NewsAdmin()
                                                      ));
                                                } else {
                                                  debugPrint('Error');
                                                }
                                              },
                                            ),
                                          ),
                                      ]
                                ),

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

  addNews(New news) async {
    dynamic newsName = news.newsName;
    dynamic newsDate = news.newsDate;
    dynamic newsLocation = news.newsLocation;
    dynamic newsDescr = news.newsDescr;
    dynamic path = news.path;

    // String apiurl = "http://localhost/test/mail.php";
    String apiurl = baseUrl + "/test/add_news.php";

    var response = await http.post(Uri.parse(apiurl), body: {
      'newsName': newsName,
      'newsDate': newsDate,
      'newsLocation': newsLocation,
      'newsDescr': newsDescr,
      'path': path
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('news added');
      // var uuid = const Uuid();
      // id = uuid.v1();

      print(response.statusCode);
      print(response.body);

      final newJson = json.decode(response.body);

      print('newsJson');
      // print(userJson);

      return New.fromJson(newJson);
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


Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Добавить новость?'.toUpperCase(),
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
                      onPressed: () {
                        var userId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewsAdmin()));
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
