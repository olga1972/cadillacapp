import 'package:flutter/material.dart';

class TitlePageAdmin extends StatelessWidget {
  const TitlePageAdmin({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return
      Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'CadillacSans',
            color: Color(0xFF8F97BF),
            height: 1.17, //line-height : font-size
          )
      );
  }

}