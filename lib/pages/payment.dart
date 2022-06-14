import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:cadillac/functions.dart';

import 'package:cadillac/widgets/titlePage.dart';

import 'package:cadillac/variables.dart';

class Payment extends StatelessWidget {
  Payment({Key? key,}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  // final void Function()? _launchURL;

  var maskFormatterCVC = MaskTextInputFormatter(
      mask: '___ CVC',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  var maskFormatterDate = MaskTextInputFormatter(
      mask: '__-20__ ММ.ГГ',
      filter: { "_": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF181c33)),
        title: 'Cadillac',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/home',
        // routes: {
        //   '/home': (context) => const Home(),
        //   '/account': (context) => const Account(),
        //   '/members': (context) => Members(),
        //   '/news': (context) => const News(),
        //   '/shop': (context) => const Shop(),
        //   '/partners': (context) => const Partners(),
        //   '/contacts': (context) => Contacts(),
        //
        // },
        home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF181c33),
          //   shadowColor: Colors.transparent,
          // ),

            body: Center(
                child: Container(
                  width: 284,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 66, bottom: 58),
                          child: const TitlePage(title: 'оплата'),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const Text(
                            'оплачивая регистрационный сбор, \nвы получаете доступ, \nк нашему клубу на целый год',
                            textAlign: TextAlign.center,
                            style:     TextStyle (
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'CadillacSans',
                              color: Color(0xFF8F97BF),
                              height: 1.5, //line-height : font-size
                            ),
                          ),
                        ),

                        FormBuilder(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'ваш email'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),
                                  FormBuilderTextField(
                                      name: 'login',
                                      style: styleFormInput,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        fillColor: Color(0XFF515569),
                                        filled: true,
                                        hintText: "Введите ваш email",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      // onChanged: _onChanged,

                                      // valueTransformer: (text) => num.tryParse(text),
                                      validator:
                                      FormBuilderValidators.compose([
                                        // FormBuilderValidators.required(context),
                                        // FormBuilderValidators.numeric(context),
                                        // FormBuilderValidators.max(context, 70),
                                      ]),
                                      keyboardType: TextInputType.emailAddress),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    margin: const EdgeInsets.only( top: 30, bottom: 30),
                                    child: Text(
                                      'На ваш Email будет отправлен \nлогин и именной номер'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: styleTitleFormInput,
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: 30),
                                    child: Text(
                                      '7 000 рублей'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle (
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'CadillacSans',
                                        color: Color(0xFF8F97BF),
                                        height: 1.4, //line-height : font-size
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Оплатить картой онлайн'.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: styleTitleFormInput,
                                    ),
                                  ),

                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child:FormBuilderTextField(
                                          name: 'card',
                                          style: styleFormInputCard,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.all(16),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            fillColor: Color(0XFFE4E6FF),
                                            filled: true,
                                            hintText: "Введите номер карты",
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF515569),
                                            ),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: SvgPicture.asset(
                                                  'assets/images/card.svg',
                                                  semanticsLabel: 'Icon card',
                                                  height: 15.0,
                                                  color: const Color(0xFF515569)
                                              ),
                                            ),
                                          ),
                                          // onChanged: _onChanged,

                                          // valueTransformer: (text) => num.tryParse(text),
                                          validator:
                                          FormBuilderValidators.compose([
                                            // FormBuilderValidators.required(context),
                                            // FormBuilderValidators.numeric(context),
                                            // FormBuilderValidators.max(context, 70),
                                          ]),
                                          keyboardType: TextInputType.text),
                                  ),

                                ]
                            )
                        ),
                        Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: 'date',
                                  style: styleFormInputCard,
                                  inputFormatters: [maskFormatterDate],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Color(0XFFE4E6FF),
                                    filled: true,
                                    hintText: '__/20__  ММ/ГГ',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF181C33),
                                    ),
                                  ),
                                  // onChanged: _onChanged,

                                  // valueTransformer: (text) => num.tryParse(text),
                                  // validator: FormBuilderValidators.compose([
                                  //   // FormBuilderValidators.required(context),
                                  //   // FormBuilderValidators.numeric(context),
                                  //   // FormBuilderValidators.max(context, 70),
                                  // ]),
                                  // keyboardType: TextInputType.text
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 10),

                                    child: FormBuilderTextField(
                                      name: 'cvc',
                                      style: styleFormInputCard,
                                      inputFormatters: [maskFormatterCVC],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(16),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        fillColor: Color(0XFFE4E6FF),
                                        filled: true,
                                        hintText: '___ CVC',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF181C33),
                                        ),
                                      ),
                                      // onChanged: _onChanged,

                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   // FormBuilderValidators.required(context),
                                      //   // FormBuilderValidators.numeric(context),
                                      //   // FormBuilderValidators.max(context, 70),
                                      // ]),
                                      // keyboardType: TextInputType.text
                                    ),
                                  )

                              )

                            ]
                        ),


                        Container(
                          width: 284,
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          child: MaterialButton(
                            padding: const EdgeInsets.all(17),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            // textColor: const Color(0xFF12141F),
                            child: Text(
                              "Оплатить онлайн".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xFF12141F)),
                            ),

                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // _formKey.currentState.save();
                              // if (_formKey.currentState.validate()) {
                              //   print(_formKey.currentState.value);
                              // } else {
                              //   print("validation failed");
                              // }
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 0, bottom: 30),
                            child: GestureDetector(
                              onTap: _launchURL,
                              // onTap: goToURL,
                              child: const Text.rich(
                                TextSpan (
                                    text: 'Нажимая Оплатить, вы соглашаетесь ',
                                    style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal, color: Color(0xFF8F97BF), height: 1.5),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'c Договором',
                                        style: TextStyle (decoration: TextDecoration.underline, decorationThickness: 2,),
                                      )
                                    ]
                                ),
                              ),

                            ),
                       ),

                  ]
                ),
            )
        )
        )
    );
  }
}

void _onChanged() {}
final Uri _url = Uri.parse('https://www.google.com');

void _launchURL() async {

  if (!await launchUrl(_url)) throw 'Could not launch $_url';
  // const url = 'https://www.google.com';  //наша ссылка
  // if (await canLaunchUrl(url)) {  //проверяем наличие браузера на устройстве
  //   await launchUrl(url, forceWebView: true);   //true если открываем в приложении, false открываем в браузере
  // } else {
  //   throw 'Could not launch $url';
}
