import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/titlePage.dart';

class Gift extends StatelessWidget {
  const Gift({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {

  return MaterialApp(

    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center (
        child: Container (
          width: 284,

          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align (
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SvgPicture.network(
                      'assets/images/close.svg',
                      semanticsLabel: 'Icon close',
                      height: 16.0,
                      color: Colors.white),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
             SvgPicture.network(
                'assets/images/gift.svg',
                semanticsLabel: 'Icon gift',
                height: 22.0,
                color: Colors.white,
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
                    SvgPicture.network(
                      'assets/images/gift.svg',
                      semanticsLabel: 'Icon gift',
                      height: 23.0,
                      color: Colors.white,
                    ),
                  ],
                )
              ),
              const Align (
                alignment: Alignment.bottomRight,
                child: Image(
                  // width: 96,
                  // height: 96,
                  image: NetworkImage('assets/images/notebook.png'),
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
