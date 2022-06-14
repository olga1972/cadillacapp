import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Accordion extends StatefulWidget {
  // final Widget title;
  final Widget content;

  // const Accordion({Key? key, required this.title, required this.content})
  const Accordion({Key? key, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Stack (
      alignment: Alignment.topCenter,
        // width: 284,
        children: [
          MaterialButton(

            // margin: const EdgeInsets.only(top: 30, bottom: 45),
            height: 48,

            minWidth: 284,
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 21),
            color: Colors.white,
            disabledColor: Colors.white,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),

            child: Column (
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10),
                  ),
                  Text( "продолжить регистрацию".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF12141F)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10),
                  ),

                ]
            ),
            onPressed: () {
            },
            //: null,
          ),
          Container (
            margin: const EdgeInsets.only(
                top: 20),

            child:
              IconButton (
                  icon: SvgPicture.asset(
                  'assets/images/arrow_down.svg',
                      semanticsLabel: 'Icon arrow down',
                      height: 6.0,
                      color: const Color(0xFF12141F)
                  ),
                  onPressed: () {
                    setState(() {
                      _showContent = !_showContent;
                    });
                  },
              ),
            ),
            _showContent
                ? Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0 ),
                    color: const Color(0xFF181C33),
                    child: widget.content
                )

                : Container()
        ]

    );

  }

}

