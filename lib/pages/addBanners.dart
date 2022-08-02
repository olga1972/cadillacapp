import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cadillac/variables.dart';
import 'package:cadillac/models/banners.dart';
import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../NavDrawerAdmin.dart';
import 'data.dart';
import 'homeAdmin.dart';

class AddBanners extends StatefulWidget {
  const AddBanners({Key? key}) : super(key: key);
  @override
  State<AddBanners> createState() => _AddBannersState();
}

class _AddBannersState extends State<AddBanners> {
  late String encode64Banner;

  @override
  void initState() {
    super.initState();
    encode64Banner = '';
  }

  final _bannersKey = GlobalKey<FormBuilderState>();

  late dynamic newBanner;
  late String id = '1';
  late String bannerId = '111';
  late String bannerName = 'name';
  late List<dynamic> bannerImage;

  late String path;
  late String platform;
  late Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    platform = Provider.of<Data>(context).data['platform'].toString();
    debugPrint(platform);

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child: Container(
            width: 284,
            margin: const EdgeInsets.only(top: 70),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(bottom: 40),
                    child: const TitlePage(title: 'добавить баннер'),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    FormBuilder(
                      key: _bannersKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                          //alignment: Alignment(-1,0),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'название баннера'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: styleTitleFormInput,
                          ),
                        ),
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: FormBuilderTextField(
                              name: 'bannerName',
                              autofocus: true,
                              cursorWidth: 1.0,
                              cursorColor: Colors.white,
                              style: styleFormInput,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                fillColor: Color(0XFF515569),
                                filled: true,
                                hintText: "название баннера",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onSaved: (value) => bannerName = value!,
                              autovalidateMode: AutovalidateMode.always,
                              validator: FormBuilderValidators.compose([
                                (val) {
                                  if (val == null) {
                                    return 'Поле bannerName не может быть пустым';
                                  } else if (val.length < 3) {
                                    return 'Минимум 3 символа';
                                  } else {
                                    return null;
                                  }
                                },
                              ]),
                              keyboardType: TextInputType.text),
                        ),
                        FormBuilderFilePicker(
                            name: "bannerImage",
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
                            selector: Column(children: [
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  width: 284,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF515569), shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10))),
                                ),
                                SvgPicture.asset(
                                  'assets/images/load.svg',
                                  semanticsLabel: 'Icon upload',
                                  height: 18.0,
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: const [
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
                            onFileLoading: (val) {
                              // debugPrint(val);
                            },
                            onSaved: (value) => {
                                  debugPrint('value'),
                                  debugPrint(value.runtimeType.toString()),
                                  bannerImage = value!,
                                }),
                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(top: 30, bottom: 45),
                          child: MaterialButton(
                            padding: const EdgeInsets.all(17),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Text(
                              "Добавить баннер".toUpperCase(),
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
                              if (_bannersKey.currentState?.saveAndValidate() ?? false) {
                                debugPrint('banner added');
                                if (platform == 'android' || platform == 'ios') {
                                  debugPrint(platform);
                                  final bytes = File(bannerImage[0].path).readAsBytesSync();
                                  setState(() {
                                    encode64Banner = base64.encode(bytes);
                                  });
                                } else {
                                  debugPrint(platform);
                                  bytes = bannerImage[0].bytes;

                                  setState(() {
                                    encode64Banner = base64.encode(bytes!);
                                  });
                                }

                                final newBanner = AdsBanner(
                                  id: id,
                                  bannerId: bannerId,
                                  bannerName: bannerName,
                                  path: encode64Banner,
                                );

                                addBanner(newBanner);
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
  }

  getPathImage(url) async {
    return url;
  }

  addBanner(AdsBanner banner) async {
    dynamic bannerName = banner.bannerName;
    dynamic path = banner.path;
    debugPrint(bannerName);

    String apiUrl = baseUrl + "/test/add_banner.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
      'bannerName': bannerName,
      'path': path,
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      debugPrint('banner added');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      final bannerJson = json.decode(response.body);
      return AdsBanner.fromJson(bannerJson);
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
        content: Text(
          'Добавить баннер?'.toUpperCase(),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
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
