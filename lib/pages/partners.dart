import 'package:flutter/material.dart';



import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/partnersList.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../models/partners.dart';
import '../variables.dart';

class Partners extends StatefulWidget {
  const Partners({Key? key}) : super(key: key);

  @override
  State<Partners> createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {

  int selectedIndex = 1;

  late Future<PartnersList> partnersList;

  // late Future<Partner> partners;
  late String partnerId;


  late String path = "assets/images/avatar.png";
  // late List<dynamic> partnerImage;
  //late Future<New> deleteNews;

  @override
  void initState() {
    super.initState();
    partnersList = getPartnersList();
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
  late String currentPartnerId;

  @override
  Widget build(BuildContext context) {
    // Widget mainWidget = const Members();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
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
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
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
                      SizedBox (
                          width: 310,
                          //height: 830,
                          //margin: const EdgeInsets.only(bottom: 40),
                          child: FutureBuilder<PartnersList>(
                              future: partnersList,
                              builder: (context, snapshot) {

                                var partners = snapshot.data?.partners;
                                List<Partner>? partnersList = snapshot.data?.partners;
                                print('partners');
                                print(partnersList);

                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            }

                            if (snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                    width: 310,
                                    height: 960,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [

                                          Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: const TitlePage(
                                                  title: 'партнеры автоклуба\ncadillac')
                                          ),

                                          SizedBox(
                                              width: 310,
                                              // height: 960,
                                              child: ListView.builder(
                                                  scrollDirection: Axis
                                                      .vertical,
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data
                                                      ?.partners.length,
                                                  itemBuilder: (
                                                      BuildContext context,
                                                      int index) {
                                                    var fileExtension = snapshot
                                                        .data?.partners[index]
                                                        .path.substring(
                                                        (snapshot.data
                                                            ?.partners[index]
                                                            .path.length)! - 3);
                                                    if (fileExtension ==
                                                        'jpg' ||
                                                        fileExtension ==
                                                            'png' ||
                                                        fileExtension ==
                                                            'svg') {
                                                      isLoadedImage = true;
                                                    } else {
                                                      isLoadedImage = false;
                                                    }
                                                    _image = File(
                                                        '${snapshot.data
                                                            ?.partners[index]
                                                            .path}');

                                                    return Container(
                                                        width: 284,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 30),
                                                        child: (isLoadedImage &&
                                                            _image.existsSync())
                                                            ? Image.file(_image,
                                                            fit: BoxFit.cover,
                                                            width: 284,
                                                            height: 160)
                                                            : const Text('no image',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight: FontWeight
                                                                  .normal,
                                                              fontFamily: 'CadillacSans',
                                                              color: Color(
                                                                  0xFF8F97BF),
                                                              height: 1.7, //line-height / font-size
                                                            ))

                                                    );
                                                  }
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
                ),
              ]
            ),
          ),

          drawer: const NavDrawer(),
        )
    );
  }

  Future<PartnersList> getPartnersList() async {
    print('getPartnersList');
    const url = baseUrl + '/test/partners_list.php';
    final response = await http.get(Uri.parse(url));
    print('response getPartnersList');
    print(response.body);
    if(response.statusCode == 200) {
      return PartnersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }


  deletePartner(partnerId) async {
    print('delete partner admin');
    String apiurl = baseUrl + "/test/delete_partner.php";

    //var partnerId;
    var response = await http.post(Uri.parse(apiurl), body: {
      'partnerId': partnerId,
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('partner deleted');
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

