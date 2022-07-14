import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../variables.dart';
//import http package manually

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{
  late String errormsg;
  late bool error, showprogress;
  late String phone, email;

  final _phone = TextEditingController();
  final _email = TextEditingController();

  startLogin() async {
    String apiurl = baseUrl + "/test/login.php";
    // String apiurl = "http://192.168.31.213/test/login.php"; //api url
    //String apiurl = "http://localhost/test/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    print("phone2 : $phone");
    print("email2: $email");

    var response = await http.post(Uri.parse(apiurl),body:{'phone': phone,'email': email});

    print('response');
    print(response.body);
    // print(response.body.substring(1));
    print(response.statusCode);
    // print(json.decode(response.body));
    //return Album.fromJson(jsonDecode(response.body));


    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      print(jsondata);
      if(jsondata["error"]){
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      }else{
        if(jsondata["success"]){
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          // String uid = jsondata["uid"];
          // String fullname = jsondata["fullname"];
          // String address = jsondata["address"];
          // print(fullname);
          print('success');
          //user shared preference to save data
        }else{
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    email = "";
    phone = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      //color set to transperent or set your own color
    ));

    return Scaffold(
      body: SingleChildScrollView(
          child:Container(
            constraints: BoxConstraints(
                minHeight:MediaQuery.of(context).size.height
              //set minimum height equal to 100% of VH
            ),
            width:MediaQuery.of(context).size.width,
            //make width of outer wrapper to 100%
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.orange,Colors.deepOrangeAccent,
                  Colors.red, Colors.redAccent,
                ],
              ),
            ), //show linear gradient background of page

            padding: const EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: const EdgeInsets.only(top:80),
                child: const Text("Sign Into System", style: TextStyle(
                    color:Colors.white,fontSize: 40, fontWeight: FontWeight.bold
                ),), //title text
              ),

              Container(
                margin: const EdgeInsets.only(top:10),
                child: const Text("Sign In using Email and Phone", style: TextStyle(
                    color:Colors.white,fontSize: 15
                ),), //subtitle text
              ),

              Container(
                //show error message here
                margin: const EdgeInsets.only(top:30),
                padding: const EdgeInsets.all(10),
                child:error? errmsg(errormsg):Container(),
                //if error == true then show error message
                //else set empty container as child
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                margin: const EdgeInsets.only(top:10),
                child: TextField(
                  controller: _phone, //set username controller
                  style:TextStyle(color:Colors.orange[100], fontSize:20),
                  decoration: myInputDecoration(
                    label: "phone",
                    icon: Icons.person,
                  ),
                  onChanged: (value){
                    //set username  text on change
                    phone = value;
                  },

                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _email, //set password controller
                  style: TextStyle(color:Colors.orange[100], fontSize:20),
                  // obscureText: true,
                  decoration: myInputDecoration(
                    label: "email",
                    icon: Icons.lock,
                  ),
                  onChanged: (value){
                    // change password text
                    email = value;
                  },

                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top:20),
                child: SizedBox(
                  height: 60, width: double.infinity,
                  child:MaterialButton(
                    onPressed: (){
                      setState(() {
                        //show progress indicator on click
                        showprogress = true;
                      });
                      startLogin();

                    },
                    child: showprogress?
                    SizedBox(
                      height:30, width:30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.orange[100],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                      ),
                    ):const Text("LOGIN NOW", style: TextStyle(fontSize: 20),),
                    // if showprogress == true then show progress indicator
                    // else show "LOGIN NOW" text
                    colorBrightness: Brightness.dark,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30)
                      //button corner radius
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top:20),
                child: InkResponse(
                    onTap:(){
                      //action on tap
                    },
                    child:const Text("Forgot Password? Troubleshoot",
                      style: TextStyle(color:Colors.white, fontSize:18),
                    )
                ),
              )
            ]),
          )
      ),
    );
  }

  InputDecoration myInputDecoration({required String label, required IconData icon}){
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color:Colors.orange[100], fontSize:20), //hint text style
      prefixIcon: Padding(
          padding: const EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Colors.orange[100],)
        //padding and icon for prefix
      ),

      contentPadding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.orange, width: 1)
      ), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color:Colors.orange, width: 1)
      ), //focus border

      fillColor: const Color.fromRGBO(251,140,0, 0.5),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text){
    //error message widget.
    return Container(
      padding: const EdgeInsets.all(15.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color:Colors.red, width:2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right:6.00),
          child: const Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}