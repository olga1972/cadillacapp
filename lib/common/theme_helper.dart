import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cadillac/variables.dart';

class ThemeHelper{

  InputDecoration textInputDecoration([String labelText="", String hintText = "", String helperText = ""]){
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.white60,
      ),
      helperStyle: styleHelperText,
      // fillColor: Color(0XFF515569),
      fillColor: HexColor("#515569"),
      filled: true,
      contentPadding: const EdgeInsets.all(16),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      // errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      // focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  // BoxDecoration inputBoxDecorationShaddow() {
  //   return BoxDecoration(boxShadow: [
  //     BoxShadow(
  //       color: Colors.black.withOpacity(0.1),
  //       blurRadius: 20,
  //       offset: const Offset(0, 5),
  //     )
  //   ]);
  // }

  // BoxDecoration buttonBoxDecoration(BuildContext context, [String color1 = "", String color2 = ""]) {
  //   Color c1 = Theme.of(context).primaryColor;
  //   Color c2 = Theme.of(context).accentColor;
  //   if (color1.isEmpty == false) {
  //     c1 = HexColor(color1);
  //   }
  //   if (color2.isEmpty == false) {
  //     c2 = HexColor(color2);
  //   }
  //
  //   return BoxDecoration(
  //     boxShadow: [
  //       BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
  //     ],
  //     gradient: LinearGradient(
  //       begin: Alignment.topLeft,
  //       end: Alignment.bottomRight,
  //       stops: [0.0, 1.0],
  //       colors: [
  //         c1,
  //         c2,
  //       ],
  //     ),
  //     color: Colors.deepPurple.shade300,
  //     borderRadius: BorderRadius.circular(30),
  //   );
  // }

  // ButtonStyle buttonStyle() {
  //   return ButtonStyle(
  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //     ),
  //     minimumSize: MaterialStateProperty.all(Size(50, 50)),
  //     backgroundColor: MaterialStateProperty.all(Colors.transparent),
  //     shadowColor: MaterialStateProperty.all(Colors.transparent),
  //   );
  // }

  AlertDialog alertDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}

class LoginFormStyle{

}