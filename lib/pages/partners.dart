import 'package:flutter/material.dart';
import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  late String partnerId;
  late String path = "assets/images/avatar.png";

  @override
  void initState() {
    super.initState();
    partnersList = getPartnersList();
  }

  bool isLoadedImage = false;
  late String currentPartnerId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF181c33),
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
          ),
          body: Center(
            child: ListView(children: [
              Center(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(
                      width: 310,
                      child: FutureBuilder<PartnersList>(
                          future: partnersList,
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
                                    width: 310,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Container(margin: const EdgeInsets.only(bottom: 20), child: const TitlePage(title: 'партнеры автоклуба\ncadillac')),
                                      SizedBox(
                                          width: 310,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data?.partners.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                if (snapshot.data?.partners[index].path != null) {
                                                  isLoadedImage = true;
                                                } else {
                                                  isLoadedImage = false;
                                                }

                                                return Container(
                                                    width: 284,
                                                    margin: const EdgeInsets.only(bottom: 30),
                                                    child: Flex(
                                                    direction: Axis.vertical,
                                                    mainAxisSize: MainAxisSize.min,

                                                        children: [
                                                      Flexible(
                                                          fit: FlexFit.loose,
                                                          child: isLoadedImage
                                                              ? GestureDetector(
                                                                child: Image.memory(
                                                                  base64.decode(snapshot.data?.partners[index].path ?? ''),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              onTap: () {
                                                                _launchURL(snapshot.data?.partners[index].partnerLink);
                                                                },
                                                              )
                                                              : const Text('no image',
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontSize: 18.0,
                                                                    fontWeight: FontWeight.normal,
                                                                    fontFamily: 'CadillacSans',
                                                                    color: Color(0xFF8F97BF),
                                                                    height: 1.7, //line-height / font-size
                                                                  ))),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Flexible(
                                                            child: Text('${snapshot.data?.partners[index].partnerTerms}',
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                  fontSize: 18.0,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily: 'CadillacSans',
                                                                  color: Colors.white,
                                                                  height: 1.17,
                                                                )),
                                                          )
                                                    ]));
                                              })),
                                    ])),
                              );
                            }
                            return const Center(child: Text('no data'));
                          }))
                ]),
              ),
            ]),
          ),
          drawer: const NavDrawer(),
        ));
  }

  Future<PartnersList> getPartnersList() async {
    const url = baseUrl + '/test/partners_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response getPartnersList');
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return PartnersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  deletePartner(partnerId) async {
    debugPrint('delete partner admin');
    String apiUrl = baseUrl + "/test/delete_partner.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
      'partnerId': partnerId,
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      debugPrint('partner deleted');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response.body;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
  void _launchURL(_url) async {
    if (await canLaunchUrl(Uri.parse(_url))) {
      //проверяем наличие браузера на устройстве
      await launchUrl(Uri.parse(_url)); //true если открываем в приложении, false открываем в браузере
    } else {
      throw 'Could not launch $_url';
    }
  }
}
