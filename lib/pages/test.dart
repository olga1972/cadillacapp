// import 'package:cadillac/models/productsList.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cadillac/pages/home.dart';
import 'package:cadillac/pages/account.dart';
import 'package:cadillac/pages/members.dart';
import 'package:cadillac/pages/news.dart';
import 'package:cadillac/pages/partners.dart';
import 'package:cadillac/pages/contacts.dart';

import 'package:cadillac/NavDrawer.dart';
import 'package:cadillac/widgets/titlePage.dart';
// import 'package:cadillac/widgets/productsList.dart';
// import 'package:cadillac/models/products.dart';
import 'package:flutter_svg/svg.dart';

//import '../models/user.dart';
import '../models/users.dart';
//import 'cardProduct.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../variables.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  //late Future<OfficesList> officesList;
  late Future<UsersList> usersList;

  // get currentUser => null;

  @override
  void initState() {
    print('init state test');
    super.initState();
    //officesList = getOfficesList();
    //officesList = readJson();
    usersList = getUsersList();
    //usersList = readJson();
    print(usersList);
    // setState(() {
    //   _items = data["items"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
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
            backgroundColor: const Color(0xFF181c33),
            shadowColor: Colors.transparent,
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
          body: MaterialButton(
            child: Text('Ок'),
            onPressed: () {
              downLoadApp();
              Navigator
                  .pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (
                          context) =>
                          Home()
                  ));
            },
          ),
          // body: FutureBuilder<UsersList>(
          //   future: usersList,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       print('snapshot.data?.users');
          //       print(snapshot.data?.users);
          //       print('lengt snapshot.data?.users');
          //       print(snapshot.data?.users?[0]);
          //       return ListView.builder(
          //           itemCount: snapshot.data?.users?.length,
          //           itemBuilder: (context, index) {
          //             return Card(
          //               child: ListTile(
          //                 title: Text('${snapshot.data?.users?[index].username}'),
          //                 // title: Text('${snapshot.data?.users[index].email}'),
          //                 // title: Text('user'),
          //                 subtitle:
          //                 Text('${snapshot.data?.users?[index]?.login}'),
          //
          //                 isThreeLine: true,
          //               ),
          //             );
          //           });
          //     } else if (snapshot.hasError) {
          //       return const Text('Error');
          //     }
          //     return const Center(child: CircularProgressIndicator());
          //   },
          // ),




          drawer: NavDrawer(),
        )
    );
  }


}

Future<UsersList> getUsersList() async {
  // const url = 'https://about.google/static/data/locations.json';
  const url = baseUrl + '/test/users_list.php';
  final response = await http.get(Uri.parse(url));
print('response test getUserLists');
print(response.body);
  if(response.statusCode == 200) {
    return UsersList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
downLoadApp() async {

  print('download');

  String apiurl = baseUrl + "/test/download.php";
  print(apiurl);

  var response = await http.post(Uri.parse(apiurl));

  if(response.statusCode == 200){
    print('success download');
    print(response.statusCode);
    return true;
  }else{
    print('error');
    throw Exception('We were not able to successfully download the json data.');
  }

}