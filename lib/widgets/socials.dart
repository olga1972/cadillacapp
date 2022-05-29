import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Socials extends StatelessWidget {
  Socials({Key? key}) : super(key: key);

  // final Uri _urlWhatsApp = Uri.parse('https://www.whatsapp.com');
  // final Uri _urlVK = Uri.parse('https://www.vk.com');
  // final Uri _urlInstagram = Uri.parse('https://www.instagram.com');
  // final Uri _urlTelegram = Uri.parse('https://www.telegram.com');

  void _launchURL(_url) async {
    if (await canLaunchUrl(Uri.parse(_url))) {  //проверяем наличие браузера на устройстве
      await launchUrl(Uri.parse(_url));   //true если открываем в приложении, false открываем в браузере
    } else {
      throw 'Could not launch $_url';
    }
  }

    // if (!await launchUrl(_urlWhatsApp)) throw 'Could not launch $_urlWhatsApp';
    //const url = 'https://www.google.com';  //наша ссылка
  //   if (await canLaunchUrl(Uri.parse(url))) {  //проверяем наличие браузера на устройстве
  //     await launchUrl(Uri.parse(url), forceWebView: true);   //true если открываем в приложении, false открываем в браузере
  //   } else {
  //     throw 'Could not launch $url';
  // }

  @override
  Widget build(BuildContext context) {
    return
      ButtonBar(
        // width: 218,
          buttonHeight: 30,
          alignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
          GestureDetector(
            // onTap: _launchURL,
            child: (
                Stack (
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xff868e96),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),

                      IconButton(
                        iconSize: 27.0,
                        icon: SvgPicture.network('assets/images/whatsapp.svg',
                          semanticsLabel: 'Icon whatsapp',
                          height: 27.0,
                          width: 27.0,
                          color: Colors.white,
                        ),
                        // onPressed: () {},
                        onPressed: () => _launchURL('https://www.whatsapp.com'),
                      )

                    ]
                )

            ),

          ),
            Stack (
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xff868e96),

                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),

                  IconButton(
                    iconSize: 27.0,
                    icon: SvgPicture.network('assets/images/vk.svg',
                      semanticsLabel: 'Icon whatsapp',
                      height: 27.0,
                      width: 31.0,
                      color: Colors.white,
                    ),
                    onPressed: () => _launchURL('https://www.vk.com'),

                  )

                ]
            ),

            Stack (
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xff868e96),

                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),

                  IconButton(
                    iconSize: 27.0,
                    icon: SvgPicture.network('assets/images/instagram.svg',
                      semanticsLabel: 'Icon whatsapp',
                      height: 27.0,
                      width: 27.0,
                      color: Colors.white,
                    ),
                    onPressed: () => _launchURL('https://www.instagram.com'),
                  )

                ]
            ),

            Stack (
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xff868e96),

                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),

                  IconButton(
                    iconSize: 28.0,
                    icon: SvgPicture.network('assets/images/telegram.svg',
                      semanticsLabel: 'Icon telegram',
                      height: 28.0,
                      width: 28.0,
                      // color: Colors.white,
                    ),
                    onPressed: () => _launchURL('https://www.telegram.com'),
                  )

                ]
            ),
          ]

      );
  }

}