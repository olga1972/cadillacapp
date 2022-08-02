import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePageAdmin.dart';
import 'package:cadillac/models/users.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../NavDrawerAdmin.dart';
import '../variables.dart';
import 'accountAdmin.dart';
import 'addUser.dart';

class MembersAdmin extends StatefulWidget {
  const MembersAdmin({Key? key}) : super(key: key);

  @override
  State<MembersAdmin> createState() => _MembersAdminState();
}

class _MembersAdminState extends State<MembersAdmin> {
  late Future<UsersList> usersList;

  @override
  void initState() {
    super.initState();
    usersList = getUsersList();
  }

  int selectedIndex = 1;

  bool isLoadedImage = false;
  bool isLoadedCar = false;
  late Uint8List image;
  late Uint8List car1;

  late String currentUserId;
  String path = "assets/images/avatar.png";

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
                width: 284,
                child: FutureBuilder<UsersList>(
                    future: usersList,
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
                                width: 284,
                                height: 860,
                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: const TitlePageAdmin(title: 'члены автоклуба'),
                                  ),
                                  SizedBox(
                                    height: 780,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        // padding: const EdgeInsets.only(top: 38, bottom: 10),
                                        itemCount: snapshot.data?.users.length,
                                        itemBuilder: (context, index) {
                                          late Uint8List bytesCar1;

                                          if (snapshot.data?.users[index].path != null) {
                                            isLoadedImage = true;
                                          } else {
                                            isLoadedImage = false;
                                          }

                                          if (snapshot.data?.users[index].car1 != null) {
                                            isLoadedCar = true;
                                            var car1Encode = snapshot.data?.users[index].car1;
                                            var car1Decode64 = base64.decode(car1Encode!);
                                            bytesCar1 = car1Decode64;
                                          } else {
                                            isLoadedCar = false;
                                          }
                                          return GestureDetector(
                                              onLongPress: () {
                                                setState(() {
                                                  // устанавливаем индекс выделенного элемента
                                                  selectedIndex = index;
                                                });
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountAdmin()));
                                              },
                                              child: Container(
                                                  width: 284,
                                                  // height: 166,
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFE4E6FF),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Flex(direction: Axis.vertical, mainAxisSize: MainAxisSize.min, children: [
                                                    Flexible(
                                                        fit: FlexFit.loose,
                                                        child: Column(children: [
                                                          Container(
                                                              margin: const EdgeInsets.only(bottom: 10),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('${snapshot.data?.users[index].username}'.toUpperCase(),
                                                                        textAlign: TextAlign.right,
                                                                        style: const TextStyle(
                                                                          fontSize: 14.0,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontFamily: 'CadillacSans',
                                                                          color: Colors.black,
                                                                          height: 1.7, //line-height / font-size
                                                                        )),
                                                                    Column(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text('именной номер'.toUpperCase(),
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                fontSize: 14.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'CadillacSans',
                                                                                color: Colors.black,
                                                                                height: 1.7, //line-height / font-size
                                                                              )),
                                                                          Text('${snapshot.data?.users[index].id}'.toString().padLeft(4, '0').toUpperCase(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 14.0,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: 'CadillacSans',
                                                                                color: Colors.black,
                                                                                height: 1.7, //line-height / font-size
                                                                              )),
                                                                        ])
                                                                  ])),
                                                          Container(
                                                            margin: const EdgeInsets.only(bottom: 10.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                ClipOval(
                                                                  child: CircleAvatar(
                                                                      radius: 48,
                                                                      backgroundColor: Colors.transparent,
                                                                      child: isLoadedImage
                                                                          ? Image.memory(base64.decode(snapshot.data?.users[index].path ?? ''),
                                                                              fit: BoxFit.cover, width: 96, height: 96)
                                                                          : const Text('no image')),
                                                                ),
                                                                isLoadedCar
                                                                    ? Image.memory(bytesCar1, fit: BoxFit.cover, width: 157, height: 79)
                                                                    : const Text('no image'),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(children: [
                                                            const SizedBox(
                                                              width: 106,
                                                            ),
                                                            SizedBox(
                                                                width: 157,
                                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                  Flexible(
                                                                    flex: 3,
                                                                    child: Text(
                                                                      '${snapshot.data?.users[index].carname}'.toUpperCase(),
                                                                      style: const TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontFamily: 'CadillacSans',
                                                                        color: Color(0xFF12141F),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child: SvgPicture.asset('assets/images/cadillac.svg',
                                                                        semanticsLabel: 'Icon car', height: 15.0),
                                                                  ),
                                                                ]))
                                                          ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                            Text('дата регистрации'.toUpperCase(),
                                                                textAlign: TextAlign.right,
                                                                style: const TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w700,
                                                                  fontFamily: 'CadillacSans',
                                                                  color: Colors.black,
                                                                  height: 1.7, //line-height / font-size
                                                                )),
                                                            Text('${snapshot.data?.users[index].dateRegister}'.toUpperCase(),
                                                                textAlign: TextAlign.left,
                                                                style: const TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontFamily: 'CadillacSans',
                                                                  color: Colors.black,
                                                                  height: 1.7, //line-height / font-size
                                                                )),
                                                          ]),
                                                          Visibility(
                                                            visible: false,
                                                            child: FormBuilderTextField(
                                                              name: 'currentNewsId',
                                                              initialValue: '${snapshot.data?.users[selectedIndex].userId}',
                                                              onSaved: (value) => currentUserId = value!,
                                                            ),
                                                          ),
                                                        ]))
                                                  ])));
                                        }),
                                  )
                                ])));
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      return const Center(child: Text('no data'));
                    }),
              ),
              Container(
                  width: 310,
                  height: 20,
                  margin: const EdgeInsets.only(left: 15, bottom: 20),
                  alignment: const Alignment(1, 1),
                  child: GestureDetector(
                    onLongPress: () {
                      Route route = MaterialPageRoute(builder: (context) => const AddUser());
                      Navigator.push(context, route);
                    },
                    child: SvgPicture.asset(
                      'assets/images/add.svg',
                      semanticsLabel: 'Icon add',
                      height: 20.0,
                    ),
                  )),
            ]))
          ])),
          drawer: const NavDrawerAdmin(),
        ));
  }
}

Future<UsersList> getUsersList() async {
  const url = baseUrl + '/test/users_list.php';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return UsersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
