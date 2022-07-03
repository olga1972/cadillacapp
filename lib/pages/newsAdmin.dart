import 'package:flutter/material.dart';


import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';

import 'package:cadillac/pages/shop.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawerAdmin.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:cadillac/widgets/bannersList.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../models/news.dart';

import '../variables.dart';
import 'addNews.dart';
import 'membersAdmin.dart';

class NewsAdmin extends StatefulWidget {
  const NewsAdmin({Key? key}) : super(key: key);

  @override
  State<NewsAdmin> createState() => _NewsAdminState();
}

class _NewsAdminState extends State<NewsAdmin> {
  int selectedIndex = 1;

  late Future<NewsList> newsList;
  late Future<New> news;
  // late File _img;
  late String path = "assets/images/avatar.png";
  bool isLoadedImage = false;
  late File _image;
  //late Future<New> deleteNews;

  @override
  void initState() {
    super.initState();
    newsList = getNewsList();
    //news = deleteNews;
    // setState(() {
    //   _items = data["items"];
    // });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
      title: 'Cadillac',
      debugShowCheckedModeBanner: false,
      //initialRoute: 'news',

      //  routes: {
      //   '/home': (context) => const Home(),
      //   // '/account': (context) => Account(userId: userId,),
      //   // '/members': (context) => Members(),
      //   '/news': (context) => const News(),
      //   '/shop': (context) => const Shop(),
      //   '/partners': (context) => Partners(),
      //   '/contacts': (context) => Contacts(),
      //
      // },

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2C335E),
          shadowColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset('assets/images/burger.svg'),
                onPressed: () { Scaffold.of(context).openDrawer(); },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),

        body: Center (
            child: ListView (
                children: [
                  Center (
                    child: Container (
                      child: Column (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container (
                                width: 320,
                                height: 830,
                                child: FutureBuilder<NewsList>(
                                    future: newsList,
                                    builder: (context, snapshot) {

                                      var news = snapshot.data?.news;
                                      List<New>? newsList = snapshot.data?.news;
                                      print('news');
                                      print(newsList);

                                      if (snapshot.connectionState != ConnectionState.done) {
                                        return const Center(child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasError) {
                                        return Center(child:Text(snapshot.error.toString()));
                                      }

                                      if (snapshot.hasData) {
                                        return Center(
                                              child: Container(
                                                  width: 320,
                                                  height: 860,
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.only(
                                                              bottom: 20),
                                                          child: const TitlePage(title: 'клубные новости')
                                                          ),
                                                        Container(
                                                            height: 740,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                                                itemCount: snapshot.data?.news?.length,
                                                                itemBuilder: (context, index) {
                                                                  String currentNewsId;
                                                                  var fileExtension = snapshot.data?.news[index].path.substring((snapshot.data?.news[index].path.length)! - 3);
                                                                  if(fileExtension == 'jpg' || fileExtension == 'png' || fileExtension == 'svg') {
                                                                    isLoadedImage = true;
                                                                  } else {
                                                                    isLoadedImage = false;
                                                                  }

                                                                  _image = File('${snapshot.data?.news?[index]?.path}');

                                                                  return Container(
                                                                      width: 320,
                                                                      // height: 166,
                                                                      margin: const EdgeInsets.only(top: 10,bottom: 10,),

                                                                      child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .center,
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [

                                                                                  Stack(
                                                                                    alignment: Alignment.centerRight,
                                                                                      clipBehavior: Clip
                                                                                          .none,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 320,
                                                                                          margin: const EdgeInsets.only(
                                                                                            bottom: 10,),
                                                                                          child: Text(
                                                                                              '${snapshot
                                                                                                  .data
                                                                                                  ?.news?[index]
                                                                                                  ?.newsDate}',
                                                                                              textAlign: TextAlign
                                                                                                  .left,
                                                                                              style: TextStyle(
                                                                                                fontSize: 32.0,
                                                                                                fontWeight: FontWeight
                                                                                                    .normal,
                                                                                                fontFamily: 'CadillacSans',
                                                                                                color: Color(
                                                                                                    0xFF8F97BF),
                                                                                                height: 1.7, //line-height / font-size
                                                                                              )
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                            onTap: () {
                                                                                              confirmDialog(context);
                                                                                              setState(() {
                                                                                                // устанавливаем индекс выделенного элемента
                                                                                                selectedIndex = index;
                                                                                              });
                                                                                              print(snapshot.data?.news?[selectedIndex].newsId);
                                                                                              var currentNewsId = snapshot.data?.news?[selectedIndex].newsId;
                                                                                              deleteNews(currentNewsId);

                                                                                              Route route = MaterialPageRoute(
                                                                                                  builder: (context) =>
                                                                                                      NewsAdmin());
                                                                                              Navigator.push(context,route);

                                                                                            },
                                                                                            child: SvgPicture.asset(
                                                                                            'assets/images/delete.svg',
                                                                                            semanticsLabel: 'Icon delete',
                                                                                            height: 20.0,

                                                                                         /*Positioned(
                                                                                            left: 300.0,
                                                                                            top: 7.0,
                                                                                            child: IconButton(
                                                                                                alignment: Alignment
                                                                                                    .centerLeft,
                                                                                                padding: const EdgeInsets
                                                                                                    .all(
                                                                                                    0),
                                                                                                iconSize: 20.0,
                                                                                                icon: SvgPicture
                                                                                                    .asset(
                                                                                                  'assets/images/delete.svg',
                                                                                                  semanticsLabel: 'Icon delete',
                                                                                                  height: 20.0,

                                                                                                ),


                                                                                                onPressed: () async {
                                                                                                  //confirmDialog(context);
                                                                                                  // Route route = MaterialPageRoute(
                                                                                                  //     builder: (
                                                                                                  //         context) => MembersAdmin());
                                                                                                  // Navigator
                                                                                                  //     .push(
                                                                                                  //     context,
                                                                                                  //     route);
                                                                                                },
                                                                                              ),*/


                                                                                            ),
                                                                                        ),
                                                                                        Visibility(
                                                                                          visible: false,
                                                                                          child: FormBuilderTextField(
                                                                                            name: 'currentNewsId',
                                                                                            initialValue: '${snapshot.data?.news?[selectedIndex].newsId}',
                                                                                            onSaved: (value) => currentNewsId = value!,
                                                                                          ),
                                                                                        ),
                                                                                      ]
                                                                                  )
                                                                                ]
                                                                            ),
                                                                            Row(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  mainAxisSize: MainAxisSize
                                                                                      .min,
                                                                                  children: [
                                                                                    Stack(
                                                                                        alignment: Alignment.centerRight,
                                                                                        clipBehavior: Clip
                                                                                            .none,
                                                                                        children: [

                                                                                          Container(
                                                                                              width: 320,
                                                                                          child: Text.rich(
                                                                                            TextSpan(
                                                                                                text: '${snapshot
                                                                                                    .data
                                                                                                    ?.news?[index]
                                                                                                    ?.newsName}'
                                                                                                    .toUpperCase(),
                                                                                                style: const TextStyle(
                                                                                                    fontSize: 14,
                                                                                                    fontWeight: FontWeight
                                                                                                        .normal,
                                                                                                    color: Colors
                                                                                                        .white,
                                                                                                    height: 1.5),
                                                                                                children: <
                                                                                                    InlineSpan>[
                                                                                                  TextSpan(
                                                                                                    text: '\ncadillac escalada'
                                                                                                        .toUpperCase(),
                                                                                                    style: const TextStyle(
                                                                                                        fontSize: 24,
                                                                                                        fontWeight: FontWeight
                                                                                                            .normal,
                                                                                                        color: Colors
                                                                                                            .white,
                                                                                                        height: 1.4),
                                                                                                  )
                                                                                                ]
                                                                                            ),
                                                                                          ),
                                                                                          ),
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              Route route = MaterialPageRoute(
                                                                                                  builder: (context) =>
                                                                                                      AddNews());
                                                                                              Navigator.push(context,route);
                                                                                            },
                                                                                            child: SvgPicture
                                                                                                .asset(
                                                                                              'assets/images/add.svg',
                                                                                              semanticsLabel: 'Icon add',
                                                                                              height: 20.0,

                                                                                            ),
                                                                                          )



                                                                                        ]

                                                                                    ),
                                                                                  ]
                                                                              ),



                                                                            Container(
                                                                                width: 284,
                                                                                height: 160,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0XffE4E6FF),
                                                                                  borderRadius: BorderRadius.all(Radius
                                                                                      .circular(20.0)),
                                                                                ),
                                                                              margin: const EdgeInsets.only(
                                                                                  bottom: 10.0,
                                                                                  top: 10),
                                                                                child: (isLoadedImage &&_image.existsSync()) ? Image.file(_image, fit: BoxFit.cover, width: 284, height: 160) :
                                                                                Text('no image',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontSize: 18.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'CadillacSans',
                                                                                      color: Color(0xFF8F97BF),
                                                                                      height: 1.7, //line-height / font-size
                                                                                    ))
                                                                            ),
                                                                            Container(
                                                                              margin: const EdgeInsets
                                                                                  .only(
                                                                                bottom: 10,),
                                                                              child: Text(
                                                                                  '${snapshot
                                                                                      .data
                                                                                      ?.news?[index]
                                                                                      ?.newsDescr}',
                                                                                  textAlign: TextAlign
                                                                                      .left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 32.0,
                                                                                    fontWeight: FontWeight
                                                                                        .normal,
                                                                                    fontFamily: 'CadillacSans',
                                                                                    color: Color(
                                                                                        0xFF8F97BF),
                                                                                    height: 1.7, //line-height / font-size
                                                                                  )
                                                                              ),
                                                                            ),

                                                                          ]
                                                                      )

                                                                  );
                                                                }
                                                            )
                                                        )
                                                  ]
                                                  )
                                              )
                                          );

                                      }
                                      return const Center(child: Text('no data'));
                                    }
                                )
                            )
                          ]
                      ),

                    ),
                  )
                ]
            )
        ),

        drawer: NavDrawerAdmin(),

      )
    );
  }

}


Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Удалить новость?'.toUpperCase(),
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
                        'Да'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: styleTextAlertDialog,
                      ),
                      onPressed: () {
                        var userId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsAdmin()));
                      },
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(14),
                      color: Color(0xFFE4E6FF),
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

Future<NewsList> getNewsList() async {
print('getNewsList');
  const url = baseUrl + '/test/news_list.php';
  final response = await http.get(Uri.parse(url));
  print('response members getUserLists');
  print(response.body);
  if(response.statusCode == 200) {
    return NewsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}


deleteNews(newsId) async {
  print('delete news admin');
  String apiurl = baseUrl + "/test/delete_news.php";

  var response = await http.post(Uri.parse(apiurl), body: {
    'newsId': newsId,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    print('news deleted');
    print(response.statusCode);
    print(response.body);
    return response.body;
    //return New.fromJson(json.decode(response.body));

    // setState(() {
    //   showprogress = false; //don't show progress indicator
    //   error = true;
    //   errormsg = jsondata["message"];
    // });

  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}