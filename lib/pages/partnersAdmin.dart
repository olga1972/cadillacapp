import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

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
                            width: 320,
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
                                  width: 320,
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
                                            width: 320,
                                            child: ListView.builder (
                                                scrollDirection: Axis.vertical,
                                                controller: ScrollController(),
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
                                                      width: 320,
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
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      isLoadedImage ? GestureDetector(
                                                                        child: SizedBox(
                                                                          width: 284,
                                                                          child: Image.memory(
                                                                            base64.decode(snapshot.data?.partners[index].path ?? ''),
                                                                            fit: BoxFit.cover,
                                                                        ),
                                                                        ),

                                                                        onTap: () {
                                                                          _launchURL(snapshot.data?.partners[index].partnerLink);
                                                                        },
                                                                      )

                                                                      : ClipRRect(
                                                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                        child: Image.asset(
                                                                          'assets/images/no-image.jpg',
                                                                          fit: BoxFit.cover,
                                                                          width: 284,
                                                                          height: 160,
                                                                        )),
                                                                      Container(
                                                                        margin: const EdgeInsets.only(left: 15),
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              // устанавливаем индекс выделенного элемента
                                                                              selectedIndex = index;
                                                                            });
                                                                            debugPrint(snapshot.data?.partners[selectedIndex].partnerId);
                                                                            var currentPartnerId = snapshot.data?.partners[selectedIndex].partnerId;
                                                                            confirmDialog(context, currentPartnerId);
                                                                          },
                                                                          onLongPress: () {
                                                                            setState(() {
                                                                              // устанавливаем индекс выделенного элемента
                                                                              selectedIndex = index;
                                                                            });
                                                                            debugPrint(snapshot.data?.partners[selectedIndex].partnerId);
                                                                            var currentPartnerId = snapshot.data?.partners[selectedIndex].partnerId;
                                                                            confirmDialog(context, currentPartnerId);
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
                                                                          initialValue: snapshot.data?.partners.length != 1 ? '${snapshot.data?.partners[selectedIndex].partnerId}' : '',
                                                                          onSaved: (value) => currentPartnerId = value!,
                                                                        ),
                                                                      ),
                                                                    ]
                                                            ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Row(
                                                                      children: [
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
                                                                      ]
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                          ]
                                                        )
                                                  );
                                                  }
                                            )
                                        ),
                                        Container(
                                            width: 320,
                                            height: 20,
                                            margin: const EdgeInsets.only(left: 15, bottom: 20),
                                            alignment: const Alignment(1, 1),
                                            child: GestureDetector(
                                                onLongPress: () {
                                                  Route route = MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddPartners());
                                                  Navigator.push(context,route).then((value) => setState(() {}));
                                                },
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text('удерживать 2 секунды!'.toUpperCase(),
                                                          style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily: 'CadillacSans',
                                                            color: Colors.white,
                                                            height: 1.7, //line-height / font-size
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 20.0),
                                                        child: SvgPicture.asset(
                                                          'assets/images/add.svg',
                                                          semanticsLabel: 'Icon add',
                                                          height: 20.0,
                                                        ),
                                                      )

                                                    ]
                                                )
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
  void _launchURL(_url) async {

    if (await canLaunchUrl(Uri.parse(_url))) {
      //проверяем наличие браузера на устройстве
      await launchUrl(Uri.parse(_url)); //true если открываем в приложении, false открываем в браузере
    } else {
      throw 'Could not launch $_url';
    }
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

Future confirmDialog(BuildContext context, currentPartnerId) async {
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
                        deletePartner(currentPartnerId);
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

