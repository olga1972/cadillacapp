import 'package:cadillac/pages/registrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:cadillac/domain/user.dart';
import 'package:cadillac/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../variables.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  final Uri url1 = Uri.parse('https://cadillacapp.ru/test/download.php');
  final Uri url2 = Uri.parse('https://cadillacapp.ru/test/download2.php');
  final Uri url3 = Uri.parse('https://cadillacapp.ru/terms_of_use.pdf');

  final AuthService _authService = AuthService();

  _showToast(String msg, {int? duration, int? position}) {
    FlutterToastr.show(msg, context, duration: duration, position: position);
  }

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Container(
        width: 284,
        margin: const EdgeInsets.only(
            top: 0),
        child: Image.asset(
          'assets/images/logo_white.png',
          fit: BoxFit.fill,
          //height: 103.0,
        )
        // child: SvgPicture.asset(
        //   'assets/images/LOGO.svg',
        //   //fit: BoxFit.fill,
        //   height: 103.0,
        //   color: Colors.white,
        // ),

      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
          width: 284,
        // padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: styleFormInput,
          decoration: InputDecoration(
          contentPadding: EdgeInsets
              .all(16),
          border: OutlineInputBorder(
          borderSide: BorderSide
              .none,
          borderRadius: BorderRadius
              .all(
          Radius.circular(10))
          ),

          fillColor: Color(
          0XFF515569),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
          color: Colors.white,
          ),
          // prefixIcon: Padding(
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     child: IconTheme(
          //         data: IconThemeData(color: Colors.white),
          //         child: icon
          //     )
          // )
          // decoration: InputDecoration(
          //     hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
          //     hintText: hint,
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white, width: 3)
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white54, width: 1)
          //     ),
          //     prefixIcon: Padding(
          //         padding: EdgeInsets.only(left: 10, right: 10),
          //         child: IconTheme(
          //             data: IconThemeData(color: Colors.white),
          //             child: icon
          //         )
          //     )
          // ),
        ),
      ));
    }

    Widget _button(String text, void Function() func){
      return MaterialButton(

        padding: const EdgeInsets.all(17),
        color: const Color.fromARGB(
            255, 255, 255, 255),
        child: Text(
            text.toUpperCase(),
            style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF12141F),
                height: 1.14)
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: (){
          func();
        },
      );
    }

    Widget _form(String label, void Function() func){
      return ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width, height: 300),
        child: Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  bottom: 10),
              child: Text(
                '?????? email'.toUpperCase(),
                textAlign: TextAlign.left,
                style: styleTitleFormInput,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(Icon(Icons.email), "?????????????? ?????? email", _emailController, false)
            ),
            Container(
              margin: const EdgeInsets.only(
                  bottom: 10),
              child: Text(
                '?????? ????????????'.toUpperCase(),
                textAlign: TextAlign.left,
                style: styleTitleFormInput,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(Icon(Icons.lock), "?????????????? ?????? ????????????", _passwordController, true)

            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  width: 284,
                    height: 50,
                    // width: MediaQuery.of(context).size.width,
                    child: _button(label, func)
                )
            )
          ],
        ),
      ));
    }

    void _loginButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;
      //User user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim()));

      dynamic user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null)
      {
        // FlutterToastr.show("Flutter Toastr is a Flutter package for non-blocking notifications", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);

        FlutterToastr.show(
            "Can't SignIn you! Please check your email/password",
            context,
            duration: FlutterToastr.lengthShort,
            position:  FlutterToastr.bottom
        );
      }else{
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User user = (await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim())) as User;
      if(user == null)
      {
        FlutterToastr.show(
            "???????????????????? ?????? ????????????????????????????????, ?????????????????? ?????? email/password",
            context,
            duration: FlutterToastr.lengthShort,
            position:  FlutterToastr.bottom
        );

      }else{
        _emailController.clear();
        _passwordController.clear();
      }
    }
    return Scaffold(
        backgroundColor: Color(0xFF181c33),
        body: Center(
        child: Container(
        // width: 284,
        // width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            _logo(),
            // SizedBox(height: 10,),
            (
                showLogin
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(alignment: Alignment.topCenter, child: Container(child: _form('??????????', _loginButtonAction))),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                          child: Text('???? ???????????????????????????????? ??????? ?????????????????? ????????????!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),

                          onTap:() {
                            setState((){
                              showLogin = false;
                            });
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                builder: (context) =>
                                RegistrationPage()
                            ));
                          }
                      ),
                    )
                  ],
                )
                    : Column(
                  children: <Widget>[
                    _form('????????????????????????????????????', _registerButtonAction),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                          child: Text('?????? ????????????????????????????????? ??????????!', style: TextStyle(fontSize: 20, color: Colors.white)),
                          onTap:() {
                            setState((){
                              showLogin = true;
                            });
                          }
                      ),
                    )
                  ],
                )
            ),

                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: GestureDetector(
                      onTap: () => launchURL('https://cadillacapp.ru/terms_of_use.pdf'),
                      child: const Text.rich(
                        TextSpan(
                            text: '?????????????????? ???? ???????????????????? ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF8F97BF), height: 1.5),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '???????????????????????????????? ???????????????????? ?? ????????????????????????????????????',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    width: 284,
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
                    child: GestureDetector(
                      onTap: () => launchURL('https://cadillacapp.ru/oferta.jpg'),
                      child: const Text.rich(
                        TextSpan(
                            text: '???????????????????????? ?? ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF8F97BF), height: 1.5),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '?????????????????? ???? ???????????????? ??????????',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 30,
                  //       bottom: 10),
                  //   child: Text('??????????????'.toUpperCase(),
                  //     textAlign: TextAlign.left,
                  //     style: styleTitleFormInput,
                  //   ),
                  // ),
                  // Column(
                  //     mainAxisAlignment: MainAxisAlignment
                  //         .spaceBetween,
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       MaterialButton(
                  //           padding: const EdgeInsets.all(17),
                  //           child: Image.asset(
                  //             'assets/images/app1.png',
                  //             fit: BoxFit.contain,
                  //             height: 58,
                  //           ),
                  //           onPressed: () {
                  //             launchURL(url1);
                  //           }),
                  //
                  //       MaterialButton(
                  //         padding: const EdgeInsets.all(17),
                  //         child: Image.asset(
                  //           'assets/images/app2.png',
                  //           fit: BoxFit.contain,
                  //           height: 58,
                  //         ),
                  //         onPressed: () {
                  //           launchURL(url2);
                  //         },
                  //       ),
                  //
                  //     ]
                  // ),

          ],
        )
        )
    )
    ]
    ))));
  }
}

void launchURL(_url) async {
  // await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication, webOnlyWindowName: "_blank");
  if (await canLaunchUrl(Uri.parse(_url))) {
    //?????????????????? ?????????????? ???????????????? ???? ????????????????????
    // await launchUrl(Uri.parse(_url)); //true ???????? ?????????????????? ?? ????????????????????, false ?????????????????? ?? ????????????????
    await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication, webOnlyWindowName: "_blank");
  } else {
    throw 'Could not launch $_url';
  }
}


