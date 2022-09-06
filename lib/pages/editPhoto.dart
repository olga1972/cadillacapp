import 'package:cadillac/pages/addPhotos.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import 'package:cadillac/widgets/titlePageAdmin.dart';

import 'package:flutter_svg/svg.dart';

import '../NavDrawerAdmin.dart';
import '../models/photos.dart';
import '../variables.dart';
import 'homeAdmin.dart';

class EditPhoto extends StatefulWidget {
  const EditPhoto({Key? key}) : super(key: key);

  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  int selectedIndex = 1;

  late Future<PhotosList> photosList;
  late String photoId;

  late String path = "assets/images/avatar.png";

  @override
  void initState() {
    super.initState();
    photosList = getPhotosList();
  }

  bool isLoadedImage = false;
  late String currentPhotoId;

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
          ),
          body: Center(
              child: ListView(children: [
            Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                    width: 320,
                    child: FutureBuilder<PhotosList>(
                        future: photosList,
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
                                  height: 960,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Container(margin: const EdgeInsets.only(bottom: 20), child: const TitlePageAdmin(title: 'редактирование \nфотографий')),
                                    SizedBox(
                                        width: 320,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.photos.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              if (snapshot.data?.photos[index].path != null) {
                                                isLoadedImage = true;
                                              } else {
                                                isLoadedImage = false;
                                              }

                                              return Container(
                                                  width: 284,
                                                  height: 92,
                                                  alignment: Alignment.center,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                  margin: const EdgeInsets.only(bottom: 30, top: 10, left: 0, right: 0),
                                                  child: SizedBox(
                                                      width: 284,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                                width: 230,
                                                                child: isLoadedImage
                                                                    ? ClipRRect(
                                                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                                        child: Image.memory(base64.decode(snapshot.data?.photos[index].path ?? ''),
                                                                            fit: BoxFit.cover, width: 284, height: 107))
                                                                    : const Text('no image',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontSize: 18.0,
                                                                          fontWeight: FontWeight.normal,
                                                                          fontFamily: 'CadillacSans',
                                                                          color: Color(0xFF8F97BF),
                                                                          height: 1.7, //line-height / font-size
                                                                        ))),
                                                            Container(
                                                                width: 20,
                                                                margin: const EdgeInsets.only(left: 30),
                                                                height: 60,
                                                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        // устанавливаем индекс выделенного элемента
                                                                        selectedIndex = index;
                                                                      });
                                                                      debugPrint(snapshot.data?.photos[selectedIndex].photoId);
                                                                      var currentPhotoId = snapshot.data?.photos[selectedIndex].photoId;
                                                                      deletePhoto(currentPhotoId);

                                                                      Route route = MaterialPageRoute(builder: (context) => const AddPhotos());
                                                                      Navigator.push(context, route);
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
                                                                      debugPrint(snapshot.data?.photos[selectedIndex].photoId);
                                                                      var currentPhotoId = snapshot.data?.photos[selectedIndex].photoId;
                                                                      deletePhoto(currentPhotoId);

                                                                      Route route = MaterialPageRoute(builder: (context) => const HomeAdmin());
                                                                      Navigator.push(context, route).then((value) => setState(() {}));
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                      'assets/images/delete.svg',
                                                                      semanticsLabel: 'Icon delete',
                                                                      height: 20.0,
                                                                    ),
                                                                  ),
                                                                ])),
                                                            Visibility(
                                                              visible: false,
                                                              child: FormBuilderTextField(
                                                                name: 'currentPhotoId',
                                                                initialValue: snapshot.data?.photos.length != 1 ? '${snapshot.data?.photos[selectedIndex].photoId}' : '',
                                                                onSaved: (value) => currentPhotoId = value!,
                                                              ),
                                                            ),
                                                          ])));
                                            })),
                                    Container(
                                        width: 280,
                                        height: 20,
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        alignment: const Alignment(1, 1),
                                        child: GestureDetector(
                                          onLongPress: () {
                                            Route route = MaterialPageRoute(builder: (context) => const AddPhotos());
                                            Navigator.push(context, route);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/add.svg',
                                            semanticsLabel: 'Icon add',
                                            height: 20.0,
                                          ),
                                        )),
                                  ])),
                            );
                          }
                          return const Center(child: Text('no data'));
                        }))
              ]),
            )
          ])),
          drawer: const NavDrawerAdmin(),
        ));
  }

  Future<PhotosList> getPhotosList() async {
    const url = baseUrl + '/test/photos_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response getPhotosList');
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return PhotosList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  deletePhoto(photoId) async {
    debugPrint('delete photo admin');
    String apiUrl = baseUrl + "/test/delete_photo.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
      'photoId': photoId,
    }, headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    });

    if (response.statusCode == 200) {
      debugPrint('photo deleted');
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
        content: Text(
          'Удалить фото?'.toUpperCase(),
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
