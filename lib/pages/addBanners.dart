// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:cadillac/variables.dart';

import 'package:cadillac/models/banners.dart';

import 'package:cadillac/widgets/titlePage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../NavDrawerAdmin.dart';

import 'homeAdmin.dart';


class AddBanners extends StatefulWidget {
  const AddBanners({Key? key}) : super(key: key);


  @override
  State<AddBanners> createState() => _AddBannersState();
}

class _AddBannersState extends State<AddBanners> {
  @override
  void initState() {
    super.initState();
  }

  final _bannersKey = GlobalKey<FormBuilderState>();

  late dynamic newBanner;
  late String id = '1';
  late String bannerId = '111';
  late String bannerName = 'name';
  late List<dynamic> bannerImage;

  late String path;

  late List<dynamic> photo;
  // final styleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  // );

  // final styleTitleFormInput = const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.normal,
  //   fontFamily: 'CadillacSans',
  //   color: Colors.white,
  //   height: 1.5, //line-height : font-size
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
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
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          //   elevation: 0.0,
          //   leading: Builder(
          //     builder: (BuildContext context) {
          //       return IconButton(
          //         icon: SvgPicture.asset('assets/images/burger.svg'),
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //         tooltip:
          //         MaterialLocalizations.of(context).openAppDrawerTooltip,
          //       );
          //     },
          //   ),
          // ),

          body: Center (
              child: Container (
                width: 284,
                margin: const EdgeInsets.only(top: 70),
                child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded (
                        child: SingleChildScrollView (
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 284,
                                    margin: const EdgeInsets.only(bottom: 40),
                                    child: const TitlePage(title: 'добавить баннер'),
                                  ),

                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FormBuilder(
                                          key: _bannersKey,
                                          autovalidateMode: AutovalidateMode.always,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
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
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        fillColor: Color(0XFF515569),
                                                        filled: true,
                                                        hintText: "название баннера",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      // onChanged: _onChanged,
                                                      onSaved: (value) => bannerName = value!,
                                                      // valueTransformer: (text) => num.tryParse(text),
                                                      // validator: FormBuilderValidators.compose([
                                                      //   // FormBuilderValidators.required(context),
                                                      //   // FormBuilderValidators.numeric(context),
                                                      //   // FormBuilderValidators.max(context, 70),
                                                      // ]),
                                                      autovalidateMode: AutovalidateMode.always,
                                                      validator:
                                                      FormBuilderValidators.compose([
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
                                                FormBuilderImagePicker(
                                                  name: 'bannerImage',
                                                  // previewHeight: 96,
                                                  // previewWidth: 96,
                                                  // previewMargin: EdgeInsets.symmetric(horizontal: 150),
                                                  previewHeight: 140,
                                                  previewWidth: 284,
                                                  previewMargin: const EdgeInsets.only(bottom: 0),
                                                  iconColor: Colors.white,
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(20)
                                                        )
                                                    ),

                                                    // labelText: 'Загрузить фото',
                                                    // labelStyle: styleHelperText,
                                                  ),
                                                  maxImages: 1,
                                                  onSaved: (
                                                      value) =>
                                                  bannerImage = value!,

                                                ),

                                                Container(
                                                  width: 284,
                                                  margin: const EdgeInsets.only(top: 30, bottom: 45),
                                                  child: MaterialButton(
                                                    padding: const EdgeInsets.all(17),
                                                    color: const Color.fromARGB(255, 255, 255, 255),
                                                    // textColor: const Color(0xFF12141F),
                                                    child: Text(
                                                      "Добавить баннер".toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 14, color: Color(0xFF12141F)),
                                                    ),

                                                    shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async{

                                                      if (_bannersKey.currentState?.saveAndValidate() ??
                                                          false) {
                                                        confirmDialog(context);
                                                        debugPrint('banner added');

                                                        path = await getpathImage(bannerImage[0].path);

                                                        final newBanner = AdsBanner(
                                                          id: id,
                                                          bannerId: bannerId,
                                                          bannerName: bannerName,
                                                          path: path,

                                                        );

                                                        addBanner(newBanner);

                                                        Navigator
                                                            .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    const HomeAdmin()
                                                            ));
                                                      } else {
                                                        debugPrint('Error');
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ]
                                          ),

                                        )
                                      ]
                                  ),
                                ]
                            )
                        ),
                      ),
                    ]
                ),
              )
          ),
          drawer: const NavDrawerAdmin(),

        )
    );
  }

  getpathImage(url) async {
    return url;
  }

  addBanner(AdsBanner banner) async {
    dynamic bannerName = banner.bannerName;
    dynamic path = banner.path;
    print(bannerName);


    // String apiurl = "http://localhost/test/mail.php";
    String apiurl = baseUrl + "/test/add_banner.php";

    var response = await http.post(Uri.parse(apiurl), body: {
      'bannerName': bannerName,
      'path': path,

    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      print('banner added');
      // var uuid = const Uuid();
      // id = uuid.v1();

      print(response.statusCode);
      print(response.body);

      final bannerJson = json.decode(response.body);

      print('bannerJson');
      // print(userJson);

      return AdsBanner.fromJson(bannerJson);
      // return User.fromJson(jsonDecode(response.body));
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
        content: Text('Добавить баннер?'.toUpperCase(),
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
                        var partnerId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeAdmin()));
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

void _onChanged() {}