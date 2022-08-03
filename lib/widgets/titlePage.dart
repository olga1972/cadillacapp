import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'CadillacSans',
          color: Colors.white,
          height: 1.17, //line-height : font-size
        ));
  }
}