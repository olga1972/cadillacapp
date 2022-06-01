import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePage.dart';

class Gift extends StatelessWidget {
  const Gift({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {

  return MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
    title: 'Cadillac',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center (
        child: Container (
          width: 320,

          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 320,
                margin: EdgeInsets.only(top: 15, right: 34),
              ),
              Align (
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SvgPicture.network(
                      'assets/images/close.svg',
                      semanticsLabel: 'Icon close',
                      height: 16.0,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                    },
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
             Container(
               width: 284,
               margin: EdgeInsets.only(bottom: 200),
             ),
              Container (
                  margin: const EdgeInsets.only(bottom: 15),
                  child: SvgPicture.network(
                  'assets/images/gift.svg',
                  semanticsLabel: 'Icon gift',
                  height: 22.0,
                  color: Colors.white,
               )
              ),

              const TitlePage(title: ' с днем рождения'),

              Container (
                margin: const EdgeInsets.only(top: 30, bottom: 44),
                child: Text('по случаю праздника дарим вам \nнашу фирменную атрибутику'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'CadillacSans',
                      color: Colors.white,
                      height: 1.7, //line-height : font-size
                    )
                )
              ),
              Container (
                margin: const EdgeInsets.only(bottom: 25),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('блокнот'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'CadillacSans',
                          color: Colors.white,
                          height: 1.7, //line-height : font-size
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: SvgPicture.network(
                        'assets/images/logo-text.svg',
                        semanticsLabel: 'Icon logo-text',
                        height: 23.0,
                        color: Colors.white,
                      ),
                    )

                  ],
                )
              ),
              const Align (
                alignment: Alignment.bottomRight,
                child: Image(
                  // width: 96,
                  // height: 96,
                  image: NetworkImage('assets/images/notebook-gift.png'),
                  fit: BoxFit.fill,
                ),
              )
            ]
          ),
        )
      )
    )
  );
}
}
