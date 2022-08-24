import 'dart:typed_data';

import 'package:cadillac/pages/partnersAdmin.dart';
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

import '../models/partners.dart';
import 'data.dart';

class AddPartners extends StatefulWidget {
  const AddPartners({Key? key}) : super(key: key);

  @override
  State<AddPartners> createState() => _AddPartnersState();
}

class _AddPartnersState extends State<AddPartners> {
  late String encode64Partner;

  @override
  void initState() {
    super.initState();
    encode64Partner = '';
  }

  final _partnersKey = GlobalKey<FormBuilderState>();

  late dynamic partner;
  late String id = '1';
  late String partnerId = '111';
  late String partnerName = 'name';
  late String partnerLink = 'link';
  late String partnerTerms = 'partnerTerms';
  late List<dynamic> partnerImage;

  late String path;
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
                                  child: const TitlePageAdmin(title: 'добавить партнера'),
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  FormBuilder(
                                    key: _partnersKey,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          'название компании'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: FormBuilderTextField(
                                            name: 'partnerName',
                                            autofocus: true,
                                            cursorWidth: 1.0,
                                            cursorColor: Colors.white,
                                            style: styleFormInput,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(16),
                                              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                              fillColor: Color(0XFF515569),
                                              filled: true,
                                              hintText: "название компании",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onSaved: (value) => partnerName = value!,
                                            autovalidateMode: AutovalidateMode.always,
                                            validator: FormBuilderValidators.compose([
                                                  (val) {
                                                if (val == null) {
                                                  return 'Поле partnersName не может быть пустым';
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
                                          'ссылка на сайт пратнера'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: FormBuilderTextField(
                                            name: 'partnerLink',
                                            autofocus: true,
                                            cursorWidth: 1.0,
                                            cursorColor: Colors.white,
                                            style: styleFormInput,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(16),
                                              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                              fillColor: Color(0XFF515569),
                                              filled: true,
                                              hintText: "название компании",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onSaved: (value) => partnerLink = value!,
                                            autovalidateMode: AutovalidateMode.always,
                                            validator: FormBuilderValidators.compose([
                                                  (val) {
                                                if (val == null) {
                                                  return 'Поле partnersLink не может быть пустым';
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
                                          name: "partnerImage",
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
                                          onFileLoading: (val) {
                                            // debugPrint(val);
                                          },
                                          onSaved: (value) =>
                                          {
                                            debugPrint('value'),
                                            debugPrint(value.runtimeType.toString()),
                                            partnerImage = value!,
                                          }),
                                      Container(
                                        margin: const EdgeInsets.only(top: 17, bottom: 10),
                                        child: Text(
                                          'сообщение'.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: styleTitleFormInput,
                                        ),
                                      ),
                                      FormBuilderTextField(
                                        name: 'partnerTerms',
                                        style: styleFormInput,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(16),
                                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                          fillColor: Color(0XFF515569),
                                          filled: true,
                                          hintText: "Дополнительные условия",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        // onChanged: _onChanged,
                                        onSaved: (value) => partnerTerms = value!,
                                        // valueTransformer: (text) => num.tryParse(text),
                                        // validator: FormBuilderValidators.compose([
                                        //   // FormBuilderValidators.required(context),
                                        //   // FormBuilderValidators.numeric(context),
                                        //   // FormBuilderValidators.max(context, 70),
                                        // ]),
                                        validator: FormBuilderValidators.compose([
                                              (val) {
                                            if (val == null) {
                                              return 'Поле partnerTerms не может быть пустым';
                                            } else if (val.length < 5) {
                                              // return 'Invalid email address';
                                              return 'Минимум 5 символа';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ]),
                                        minLines: 6, // any number you need (It works as the rows for the textarea)
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                      ),
                                      Container(
                                        width: 284,
                                        margin: const EdgeInsets.only(top: 30, bottom: 45),
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(17),
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                          child: Text(
                                            "Добавить партнера".toUpperCase(),
                                            style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            platform = Provider
                                                .of<Data>(context, listen: false)
                                                .data['platform'].toString();
                                            debugPrint(platform);
                                            if (_partnersKey.currentState?.saveAndValidate() ?? false) {
                                              debugPrint('Partner added');
                                              if (platform == 'android' || platform == 'ios') {
                                                debugPrint(platform);
                                                final bytes = File(partnerImage[0].path).readAsBytesSync();

                                                debugPrint(bytes.runtimeType.toString());
                                                setState(() {
                                                  encode64Partner = base64.encode(bytes);
                                                });

                                                debugPrint(encode64Partner);
                                              } else {
                                                debugPrint(platform);
                                                bytes = partnerImage[0].bytes;

                                                setState(() {
                                                  encode64Partner = base64.encode(bytes!);
                                                });
                                              }

                                              final partner = Partner(
                                                id: id,
                                                partnerId: partnerId,
                                                partnerName: partnerName,
                                                path: encode64Partner,
                                                partnerLink: partnerLink,
                                                partnerTerms: partnerTerms,
                                              );
                                              confirmDialog(context, partner);
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

  getPathImage(url) async {
    return url;
  }


}

addPartner(Partner partner) async {
  dynamic partnerName = partner.partnerName;
  dynamic partnerLink = partner.partnerLink;
  dynamic partnerTerms = partner.partnerTerms;
  dynamic path = partner.path;

  String apiUrl = baseUrl + "/test/add_partner.php";

  var response = await http.post(Uri.parse(apiUrl), body: {
    'partnerName': partnerName,
    'partnerLink': partnerLink,
    'partnerTerms': partnerTerms,
    'path': path,
  }, headers: {
    'Accept': 'application/json, charset=utf-8',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
  });

  if (response.statusCode == 200) {
    debugPrint('partner added');

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    final partnerJson = json.decode(response.body);
    return Partner.fromJson(partnerJson);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

Future confirmDialog(BuildContext context, partner) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Добавить партнера?'.toUpperCase(),
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
                    addPartner(partner);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PartnersAdmin()));
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
