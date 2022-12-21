import 'package:flutter/material.dart';

import 'package:cadillac/NavDrawerAdmin.dart';
import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../models/news.dart';

import '../variables.dart';
import 'addNews.dart';
import 'editAds.dart';

class NewsAdmin extends StatefulWidget {
  const NewsAdmin({Key? key}) : super(key: key);

  @override
  State<NewsAdmin> createState() => _NewsAdminState();
}

class _NewsAdminState extends State<NewsAdmin> {
  late Future<NewsList> newsList;

  @override
  void initState() {
    super.initState();
    newsList = getNewsList();
  }

  int selectedIndex = 1;
  late Future<New> news;

  late String path = "assets/images/avatar.png";
  bool isLoadedImage = false;
  late String currentNewsId;

  @override
  Widget build(BuildContext context) {
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
                    icon: SvgPicture.asset('assets/images/burger.svg'),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: <Widget>[
                Container(
                  width: 160,
                  margin: const EdgeInsets.only(top: 22, right: 18.0),
                  child: const Text(
                    'Редактировать рекламу',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'CadillacSans',
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(0),
                  iconSize: 22.0,
                  icon: SvgPicture.asset(
                    'assets/images/edit.svg',
                    semanticsLabel: 'Icon edit',
                    height: 15.0,
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => const EditAds());
                    Navigator.push(context, route).then((value) => setState(() {}));
                  },
                ),
              ]),
          body: Center(
              child: ListView(children: [
            Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                    width: 320,
                    child: FutureBuilder<NewsList>(
                        future: newsList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(child: Text(snapshot.error.toString()));
                          }

                          if (snapshot.hasData) {
                            return Center(
                                child: SizedBox(
                                    width: 320,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Container(margin: const EdgeInsets.only(bottom: 20, top: 20), child: const TitlePageAdmin(title: 'клубные новости')),
                                      SizedBox(
                                          width: 320,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              controller: ScrollController(),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data?.news.length,
                                              itemBuilder: (context, index) {
                                                if (snapshot.data?.news[index].path != null) {
                                                  isLoadedImage = true;
                                                } else {
                                                  isLoadedImage = false;
                                                }

                                                return Container(
                                                    width: 320,
                                                    margin: const EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.min, children: [
                                                            Stack(alignment: Alignment.centerRight, clipBehavior: Clip.none, children: [
                                                              Container(
                                                                width: 320,
                                                                margin: const EdgeInsets.only(
                                                                  bottom: 10,
                                                                ),
                                                                child: Text('${snapshot.data?.news[index].newsDate}',
                                                                    textAlign: TextAlign.left,
                                                                    style: const TextStyle(
                                                                      fontSize: 32.0,
                                                                      fontWeight: FontWeight.normal,
                                                                      fontFamily: 'CadillacSans',
                                                                      color: Color(0xFF8F97BF),
                                                                      height: 1.7, //line-height / font-size
                                                                    )),
                                                              ),

                                                              Visibility(
                                                                visible: false,
                                                                child: FormBuilderTextField(
                                                                  name: 'currentNewsId',
                                                                  initialValue: snapshot.data?.news.length != 1 ? '${snapshot.data?.news[selectedIndex].newsId}' : '',
                                                                  onSaved: (value) => currentNewsId = value!,
                                                                ),
                                                              ),
                                                            ])
                                                          ]),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.min, children: [
                                                            Stack(alignment: Alignment.centerRight, clipBehavior: Clip.none, children: [
                                                              SizedBox(
                                                                width: 320,
                                                                child: Text.rich(
                                                                  TextSpan(
                                                                      text: '${snapshot.data?.news[index].newsName}'.toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white, height: 1.5),
                                                                      children: <InlineSpan>[
                                                                        TextSpan(
                                                                          text: '\ncadillac escalade'.toUpperCase(),
                                                                          style: const TextStyle(
                                                                              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white, height: 1.4),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),

                                                            ]),
                                                          ]),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                  width: 284,
                                                                  height: 160,
                                                                  decoration: const BoxDecoration(
                                                                    color: Color(0XffE4E6FF),
                                                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                  ),
                                                                  margin: const EdgeInsets.only(bottom: 10.0, top: 10),
                                                                  child: isLoadedImage
                                                                      ? Image.memory(base64.decode(snapshot.data?.news[index].path ?? ''),
                                                                          fit: BoxFit.cover, width: 284, height: 160)
                                                                      : const Text('no image',
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontSize: 18.0,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontFamily: 'CadillacSans',
                                                                            color: Color(0xFF8F97BF),
                                                                            height: 1.7, //line-height / font-size
                                                                          ))),
                                                              Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                                                                    child: GestureDetector(
                                                                      onLongPress: () {
                                                                        setState(() {
                                                                          // устанавливаем индекс выделенного элемента
                                                                          selectedIndex = index;
                                                                        });
                                                                        debugPrint(snapshot.data?.news[selectedIndex].newsId);
                                                                        var currentNewsId = snapshot.data?.news[selectedIndex].newsId;
                                                                        confirmDialog(context, currentNewsId);

                                                                      },
                                                                      onTap: () {
                                                                        setState(() {
                                                                          // устанавливаем индекс выделенного элемента
                                                                          selectedIndex = index;
                                                                        });
                                                                        debugPrint(snapshot.data?.news[selectedIndex].newsId);
                                                                        var currentNewsId = snapshot.data?.news[selectedIndex].newsId;
                                                                        confirmDialog(context, currentNewsId);

                                                                      },
                                                                      child: SvgPicture.asset(
                                                                        'assets/images/delete.svg',
                                                                        semanticsLabel: 'Icon delete',
                                                                        height: 20.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 20.0,),
                                                                    child: GestureDetector(
                                                                      onLongPress: () {
                                                                        Route route = MaterialPageRoute(builder: (context) => const AddNews());
                                                                        Navigator.push(context, route);
                                                                      },
                                                                      onTap: () {
                                                                        Route route = MaterialPageRoute(builder: (context) => const AddNews());
                                                                        Navigator.push(context, route);
                                                                      },
                                                                      child: SvgPicture.asset(
                                                                        'assets/images/add.svg',
                                                                        semanticsLabel: 'Icon add',
                                                                        height: 20.0,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ]
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets.only(
                                                              bottom: 10,
                                                            ),
                                                            child: Text('${snapshot.data?.news[index].newsDescr}',
                                                                textAlign: TextAlign.left,
                                                                style: const TextStyle(
                                                                  fontSize: 16.0,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily: 'CadillacSans',
                                                                  color: Color(0xFF8F97BF),
                                                                  height: 1.7, //line-height / font-size
                                                                )),
                                                          ),
                                                        ]));
                                              }))
                                    ])));
                          }
                          return const Center(child: Text('no data'));
                        }))
              ]),
            )
          ])),
          drawer: const NavDrawerAdmin(),
        ));
  }
}

Future confirmDialog(BuildContext context, currentNewsId) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Удалить новость?'.toUpperCase(),
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
                    deleteNews(currentNewsId);
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

Future<NewsList> getNewsList() async {
  const url = baseUrl + '/test/news_list.php';
  final response = await http.get(Uri.parse(url));
  debugPrint('response getNewsLists');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return NewsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

deleteNews(newsId) async {
  String apiUrl = baseUrl + "/test/delete_news.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
    'newsId': newsId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    debugPrint('news deleted');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    return response.body;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
