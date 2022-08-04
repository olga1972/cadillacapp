import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';
import '../models/partners.dart';
import '../variables.dart';
import 'addPartners.dart';


class PartnersAdmin extends StatefulWidget {
  const PartnersAdmin({Key? key}) : super(key: key);

  @override
  State<PartnersAdmin> createState() => _PartnersAdminState();
}

class _PartnersAdminState extends State<PartnersAdmin> {

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
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                );
              },
            ),
          ),
          body: Center(
            child: ListView (
                children: [
                  Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: [
                          SizedBox (
                            width: 310,
                            child: FutureBuilder<PartnersList>(
                              future: partnersList,
                              builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(child:Text(snapshot.error.toString()));
                            }

                            if (snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                  width: 310,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Container(
                                          margin: const EdgeInsets.only(
                                          bottom: 20),
                                            child: const TitlePageAdmin(title: 'партнеры автоклуба\ncadillac'),
                                        ),

                                        SizedBox (
                                            width: 310,
                                            child: ListView.builder (
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot.data?.partners.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  if (snapshot.data?.partners[index].path != null) {
                                                    isLoadedImage = true;
                                                  } else {
                                                    isLoadedImage = false;
                                                  }
                                                  return
                                                      Container (
                                                      width: 310,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius
                                                            .circular(10.0)),
                                                      ),
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(bottom: 30,),
                                                            child: Flex(
                                                                direction: Axis.vertical,
                                                                mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Flexible(
                                                                fit: FlexFit.loose,
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  isLoadedImage ? Image.memory(
                                                                    base64.decode(snapshot.data?.partners[index].path ?? ''),
                                                                    fit: BoxFit.cover, width: 270)
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
                                                                      )),
                                                                  Container(
                                                                    margin: const EdgeInsets.only(left: 15),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        confirmDialog(context);
                                                                        setState(() {
                                                                          // устанавливаем индекс выделенного элемента
                                                                          selectedIndex = index;
                                                                        });
                                                                        debugPrint(snapshot.data?.partners[selectedIndex].partnerId);
                                                                        var currentPartnerId = snapshot.data?.partners[selectedIndex].partnerId;
                                                                        deletePartner(currentPartnerId);
                                                                      },
                                                                      child: SvgPicture.asset(
                                                                        'assets/images/delete.svg',
                                                                        semanticsLabel: 'Icon delete',
                                                                        height: 20.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible: false,
                                                                    child: FormBuilderTextField(
                                                                      name: 'currentPartnerId',
                                                                      initialValue: '${snapshot.data?.partners[selectedIndex].partnerId}',
                                                                      onSaved: (value) => currentPartnerId = value!,
                                                                    ),
                                                                  ),
                                                                ]
                                                            )
                                                            ),
                                                          ]
                                                        )
                                                  );
                                                  }
                                            )
                                        ),
                                        Container(
                                            width: 310,
                                            height: 20,
                                            margin: const EdgeInsets.only(left: 15, bottom: 20),
                                            alignment: const Alignment(1, 1),
                                            child: GestureDetector(
                                                onLongPress: () {
                                                  Route route = MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddPartners());
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
          )
        ]
    )
    ),

          drawer: const NavDrawerAdmin(),
        )
    );
  }
  Future<PartnersList> getPartnersList() async {
    const url = baseUrl + '/test/partners_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response getPartnersList');
    debugPrint(response.body);
    if(response.statusCode == 200) {
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
}

Future confirmDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('Удалить партнера?'.toUpperCase(),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PartnersAdmin()));
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

