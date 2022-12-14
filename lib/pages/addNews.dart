import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';

import 'package:cadillac/widgets/titlePageAdmin.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../NavDrawerAdmin.dart';
import '../models/news.dart';
import 'data.dart';
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
    debugPrint('init state add news');
    super.initState();
    encode64News = '';
  }
  //
  final _newsKey = GlobalKey<FormBuilderState>();

  late dynamic news;

  late String id = '1';
  late String newsId = '111';
  late String newsName = 'name';
  late String newsDate = 'date';
  late String newsLocation = 'location';
  late String newsDescr = 'descr';
  late String path = 'path';

  late List<dynamic> newsImage;
  late String platform;
  late Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data> (
        create: (context) => Data(),
    builder: (context, child) {
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
                              const NewsAdmin()));
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
                              child: const TitlePageAdmin(title: 'добавить новость'),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                              FormBuilder(
                                key: _newsKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                          fillColor: Color(0XFF515569),
                                          filled: true,
                                          hintText: "заголовок новости",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onSaved: (value) => newsName = value!,
                                        autovalidateMode: AutovalidateMode.always,
                                        validator: FormBuilderValidators.compose([
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
                                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                          fillColor: Color(0XFF515569),
                                          filled: true,
                                          hintText: "дата проведения",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onSaved: (value) => newsDate = value!,
                                        validator: FormBuilderValidators.compose([
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
                                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                          fillColor: Color(0XFF515569),
                                          filled: true,
                                          hintText: "место проведения",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onSaved: (value) => newsLocation = value!,
                                        validator: FormBuilderValidators.compose([
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
                                    margin: const EdgeInsets.only(top: 17, bottom: 10),
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
                                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                      fillColor: Color(0XFF515569),
                                      filled: true,
                                      hintText: "Введите описание",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),

                                    onSaved: (value) => newsDescr = value!,

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
                                    ]),
                                    minLines: 6,
                                    // any number you need (It works as the rows for the textarea)
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 20),

                                  FormBuilderFilePicker(
                                      name: "newsImage",
                                      decoration: const InputDecoration(
                                        isCollapsed: true,
                                        fillColor: Color(0xff515569),
                                        iconColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        prefix: null,
                                        prefixIcon: null,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          //gapPadding: 40,
                                        ),
                                      ),
                                      maxFiles: 3,
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
                                      // onFileLoading: (val) {
                                      //   // print(val);
                                      // },

                                      onSaved: (value) =>
                                      {
                                        print('value'),
                                        print(value),
                                        newsImage = value!,

                                      }
                                  ),

                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(top: 30, bottom: 45),
                                    child: MaterialButton(
                                      padding: const EdgeInsets.all(17),
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      child: Text(
                                        "Создать".toUpperCase(),
                                        style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        platform = Provider
                                            .of<Data>(context, listen: false)
                                            .data['platform'].toString();
                                        debugPrint(platform);
                                        if (_newsKey.currentState?.saveAndValidate() ?? false) {
                                          debugPrint('News added');
                                          if (platform == 'android' || platform == 'ios') {
                                            debugPrint(platform);
                                            final bytes = File(newsImage[0].path).readAsBytesSync();

                                            debugPrint(bytes.runtimeType.toString());
                                            setState(() {
                                              encode64News = base64.encode(bytes);
                                            });
                                          } else {
                                            debugPrint(platform);
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
                                            path: encode64News);
                                            //confirmDialog(context, news);
                                            addNews(news);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NewsAdmin()));
                                        } else {
                                          debugPrint('Error');
                                        }
                                      },
                                    ),
                                  ),
                                ]),
                              )
                            ]),
                          ])),
                    ),
                  ]),
                )),
            drawer: const NavDrawerAdmin(),
          ));
    });
  }


}

addNews(New news) async {
  dynamic newsName = news.newsName;
  dynamic newsDate = news.newsDate;
  dynamic newsLocation = news.newsLocation;
  dynamic newsDescr = news.newsDescr;
  dynamic path = news.path;

  String apiUrl = baseUrl + "/test/add_news.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
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
    debugPrint('news added');

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    final newJson = json.decode(response.body);
    return New.fromJson(newJson);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

Future confirmDialog(BuildContext context, news) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Добавить новость?'.toUpperCase(),
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
                    addNews(news);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NewsAdmin()));

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
