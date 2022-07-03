// import 'dart:html';
import 'dart:typed_data';

import 'package:cadillac/pages/addBanners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/shop.dart';

import 'package:cadillac/pages/contacts.dart';

import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/partnersList.dart';
import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';
import '../models/banners.dart';
import '../models/partners.dart';
import '../variables.dart';
import 'addPartners.dart';
import 'homeAdmin.dart';


class EditAds extends StatefulWidget {
  EditAds({Key? key}) : super(key: key);

  @override
  State<EditAds> createState() => _EditAdsState();
}

class _EditAdsState extends State<EditAds> {

  int selectedIndex = 1;

  late Future<BannersList> bannersList;

  // late Future<Partner> partners;
  late String bannerId;


  late String path = "assets/images/avatar.png";
  // late List<dynamic> partnerImage;
  //late Future<New> deleteNews;

  @override
  void initState() {
    super.initState();
    bannersList = getBannersList();
    //news = deleteNews;
    // setState(() {
    //   _items = data["items"];
    // });
  }
  // final List<String> partners = <String>[
  //   "assets/images/golf_club.png",
  //   "assets/images/image16.png",
  //   "assets/images/image18.png",
  //   "assets/images/image19.png",
  //   "assets/images/image17.png",
  // ];
  //
  // get currentUser => null;
  bool isLoadedImage = false;
  late File _image;
  late String currentBannerId;

  @override
  Widget build(BuildContext context) {
    // Widget mainWidget = const Members();


    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,

        routes: {
          // '/home': (context) => const Home(),
          // '/account': (context) => Account(currentUser: currentUser),
          // '/members': (context) => Members(),
          // '/news': (context) => const News(),
          // '/shop': (context) => const Shop(),
          // '/partners': (context) => Partners(),
          // '/contacts': (context) => Contacts(),

        },
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
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          body: Center(
              child: ListView (
                  children: [
                    Center(
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment
                          //     .center,
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              Container (
                                  width: 320,
                                  //height: 830,
                                  //margin: const EdgeInsets.only(bottom: 40),
                                  child: FutureBuilder<BannersList>(
                                      future: bannersList,
                                      builder: (context, snapshot) {

                                        var banners = snapshot.data?.banners;
                                        List<AdsBanner>? bannersList = snapshot.data?.banners;
                                        print('banners');
                                        print(bannersList);

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
                                                height: 960,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      Container(
                                                          margin: const EdgeInsets.only(
                                                              bottom: 20),
                                                          child: const TitlePage(title: 'редактирование \nрекламы')
                                                      ),

                                                      Container (
                                                          width: 320,
                                                          // height: 960,
                                                          child: ListView.builder (
                                                              scrollDirection: Axis.vertical,
                                                              shrinkWrap: true,
                                                              itemCount: snapshot.data?.banners?.length,
                                                              itemBuilder: (BuildContext context, int index) {
                                                                var fileExtension = snapshot.data?.banners[index].path.substring((snapshot.data?.banners[index].path.length)! - 3);
                                                                if(fileExtension == 'jpg' || fileExtension == 'png' || fileExtension == 'svg') {
                                                                  isLoadedImage = true;
                                                                } else {
                                                                  isLoadedImage = false;
                                                                }
                                                                _image = File('${snapshot.data?.banners?[index]?.path}');

                                                                return Container (
                                                                    width: 284,
                                                                    height: 92,
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      //color: Color(0XffE4E6FF),
                                                                      borderRadius: BorderRadius.all(Radius
                                                                          .circular(10.0)),
                                                                    ),
                                                                    margin: const EdgeInsets.only(bottom: 30, top: 10, left: 0,right: 0),
                                                                    child: Container(
                                                                        //margin: const EdgeInsets.only(right: 30),
                                                                    width: 284,
                                                                    child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                              width: 230,
                                                                              child: (isLoadedImage &&_image.existsSync()) ? ClipRRect(borderRadius: BorderRadius.all(Radius
                                                                                  .circular(10.0)), child: Image.file(_image, fit: BoxFit.cover, width: 284, height: 92))
                                                                                  :  Text('no image',
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
                                                                            width: 20,
                                                                            margin: const EdgeInsets.only(left: 30),
                                                                            height: 60,
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    //confirmDialog(context);
                                                                                    setState(() {
                                                                                      // устанавливаем индекс выделенного элемента
                                                                                      selectedIndex = index;
                                                                                    });
                                                                                    print(snapshot.data?.banners?[selectedIndex].bannerId);
                                                                                    var currentBannerId = snapshot.data?.banners?[selectedIndex].bannerId;
                                                                                    deleteBanner(currentBannerId);

                                                                                    Route route = MaterialPageRoute(
                                                                                        builder: (context) =>
                                                                                            AddBanners());
                                                                                    Navigator.push(context,route);

                                                                                  },
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/images/edit.svg',
                                                                                    semanticsLabel: 'Icon edit',
                                                                                    height: 20.0,
                                                                                  ),

                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    confirmDialog(context);
                                                                                    setState(() {
                                                                                      // устанавливаем индекс выделенного элемента
                                                                                      selectedIndex = index;
                                                                                    });
                                                                                    print(snapshot.data?.banners?[selectedIndex].bannerId);
                                                                                    var currentBannerId = snapshot.data?.banners?[selectedIndex].bannerId;
                                                                                    deleteBanner(currentBannerId);

                                                                                    Route route = MaterialPageRoute(
                                                                                        builder: (context) =>
                                                                                            HomeAdmin());
                                                                                    Navigator.push(context,route);

                                                                                  },
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/images/delete.svg',
                                                                                    semanticsLabel: 'Icon delete',
                                                                                    height: 20.0,
                                                                                  ),

                                                                                ),
                                                                            ]
                                                                            )

                                                                          ),
                                                                          Visibility(
                                                                            visible: false,
                                                                            child: FormBuilderTextField(
                                                                              name: 'currentBannerId',
                                                                              initialValue: '${snapshot.data?.banners?[selectedIndex].bannerId}',
                                                                              onSaved: (value) => currentBannerId = value!,
                                                                            ),
                                                                          ),
                                                                        ]
                                                                    )
                                                                    )
                                                                );

                                                              }
                                                          )
                                                      ),
                                                      Container(
                                                          width: 280,
                                                          height: 20,
                                                          margin: const EdgeInsets.only(left: 10,),
                                                          alignment: Alignment(1, 1),
                                                          child: GestureDetector(
                                                            onLongPress: () {
                                                              Route route = MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddBanners());
                                                              Navigator.push(context,route);
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/add.svg',
                                                              semanticsLabel: 'Icon add',
                                                              height: 20.0,

                                                            ),
                                                          )

                                                      ),

                                                    ]
                                                )

                                            ),
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
  Future<BannersList> getBannersList() async {
    print('getBannersList');
    const url = baseUrl + '/test/banners_list.php';
    final response = await http.get(Uri.parse(url));
    print('response getBannersList');
    print(response.body);
    if(response.statusCode == 200) {
      return BannersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }


  deleteBanner(bannerId) async {
    print('delete banner admin');
    String apiurl = baseUrl + "/test/delete_banner.php";

    //var partnerId;
    var response = await http.post(Uri.parse(apiurl), body: {
      'bannerId': bannerId,
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('banner deleted');
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
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Подтвердите ваш заказ'),
        content: Text('Удалить рекламу?'.toUpperCase(),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeAdmin()));
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



