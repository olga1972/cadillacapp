import 'dart:typed_data';
import 'package:cadillac/pages/shopAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cadillac/utils/generate_password.dart';

import 'package:cadillac/variables.dart';
import 'package:cadillac/widgets/titlePageAdmin.dart';


import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:cadillac/NavDrawerAdmin.dart';
import 'package:cadillac/models/products.dart';
import 'package:cadillac/pages/data.dart';
import 'membersAdmin.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late String encode64Product;

  @override
  void initState() {
    super.initState();
    encode64Product = '';
  }

  final _productsKey = GlobalKey<FormBuilderState>();
  late String id = '1';
  late String categoryId = '1';
  late String category = 'category';
  late String productId = '1';
  late dynamic productName = ' name';
  late dynamic productPrice = 'price';
  late dynamic productImage = 'image';

  late String platform;
  late Uint8List? bytes;

  dynamic currentProduct;
  dynamic newUserProduct;

  List<String> categoriesName = [
    'футболки',
    'худи с капюшоном',
    'худи без капюшона',
    'бейсболки',
    'шапки',
    'дождевики',
    'наклейки',
    'блокноты',
    'зучки',
    'авто-рамки'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data> (
        create: (context) => Data(),
        builder: (context, child) {
          return MaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2C335E)),
              title: 'Cadillac',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                    child: Container(
                      width: 284,
                      margin: const EdgeInsets.only(top: 70),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Container(
                                  width: 284,
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: const TitlePageAdmin(title: 'добавить новый товар'),
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  FormBuilder(
                                      key: _productsKey,
                                      autovalidateMode: AutovalidateMode.always,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            'категория'.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: styleTitleFormInput,
                                          ),
                                        ),
                                        FormBuilderDropdown(
                                          name: 'category',
                                          elevation: 0,
                                          icon: SvgPicture.asset(
                                            'assets/images/caret-down-solid.svg',
                                            semanticsLabel: 'Icon whatsapp',
                                            height: 16.0,
                                            width: 10.0,
                                            color: Colors.white,
                                          ),
                                          autofocus: true,
                                          style: styleFormInput,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(16),
                                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                            fillColor: Color(0XFF515569),
                                            filled: true,
                                            hintText: "Введите категорию",
                                            hintStyle: TextStyle(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          dropdownColor: const Color(0XFF363b57),
                                          alignment: Alignment.bottomLeft,
                                          items: categoriesName
                                              .map((category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(category),
                                          )).toList(),
                                          onSaved: (value) => category = value! as String,
                                          autovalidateMode: AutovalidateMode.always,
                                          validator: FormBuilderValidators.compose([
                                                (val) {
                                              if (val == '') {
                                                return 'Поле category не может быть пустым';
                                              } else {
                                                return null;
                                              }
                                            }
                                          ]),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: FormBuilderTextField(
                                            name: 'categoryId',
                                            initialValue: '1',
                                            onSaved: (value) => categoryId = value!,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: Text(
                                            'название товара'.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: styleTitleFormInput,
                                          ),
                                        ),
                                        FormBuilderTextField(
                                            name: 'productName',
                                            cursorWidth: 1.0,
                                            cursorColor: Colors.white,
                                            style: styleFormInput,
                                            autovalidateMode: AutovalidateMode.always,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(16),
                                              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                              fillColor: Color(0XFF515569),
                                              filled: true,
                                              hintText: "Введите название товара",
                                              hintStyle: TextStyle(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            validator: FormBuilderValidators.compose([
                                                  (val) {
                                                if (val == null) {
                                                  return 'Поле productName не может быть пустым';
                                                } else {
                                                  return null;
                                                }
                                              }
                                            ]),
                                            onSaved: (value) => productName = value!,
                                            keyboardType: TextInputType.text),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: Text(
                                            'цена товара'.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: styleTitleFormInput,
                                          ),
                                        ),
                                        FormBuilderTextField(
                                            name: 'productPrice',
                                            cursorWidth: 1.0,
                                            cursorColor: Colors.white,
                                            style: styleFormInput,
                                            autovalidateMode: AutovalidateMode.always,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(16),
                                              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                              fillColor: Color(0XFF515569),
                                              filled: true,
                                              hintText: "Введите цену товара",
                                              hintStyle: TextStyle(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            onSaved: (value) => productPrice = value!,
                                            keyboardType: TextInputType.text),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: Text(
                                            'изображение товара'.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: styleTitleFormInput,
                                          ),
                                        ),
                                        FormBuilderFilePicker(
                                            name: "productImage",
                                            decoration: const InputDecoration(
                                              fillColor: Color(0xff515569),
                                              iconColor: Colors.white,
                                              contentPadding: EdgeInsets.all(0),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                //gapPadding: 40,
                                              ),
                                            ),
                                            maxFiles: null,
                                            previewImages: true,
                                            onChanged: (val) => {},
                                            typeSelectors: [
                                              TypeSelector(
                                                type: FileType.any,
                                                selector: Column(children: [
                                                  Stack(alignment: Alignment.center, children: [
                                                    Container(
                                                      width: 284,
                                                      height: 160,
                                                      decoration: const BoxDecoration(
                                                          color: Color(0xFF515569),
                                                          shape: BoxShape.rectangle,
                                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/load.svg',
                                                      semanticsLabel: 'Icon upload',
                                                      height: 18.0,
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: const [
                                                            SizedBox(height: 40),
                                                            Text('Загрузить фото',
                                                                style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.normal,
                                                                    fontFamily: 'CadillacSans',
                                                                    color: Colors.white,
                                                                    height: 1.4 //line-height : font-size
                                                                ),
                                                                textAlign: TextAlign.center),
                                                            Icon(
                                                              Icons.file_upload,
                                                              semanticLabel: 'Icon upload',
                                                              size: 18.0,
                                                              color: Colors.white,
                                                            )
                                                          ]),
                                                    )
                                                  ]),
                                                ]),
                                              ),

                                            ],
                                            onFileLoading: (val) {
                                              // debugPrint(val);
                                            },
                                            onSaved: (value) =>
                                            {
                                              debugPrint('value'),
                                              debugPrint(value.runtimeType.toString()),
                                              productImage = value!,
                                            }),
                                        Container(
                                            width: 284,
                                            margin: const EdgeInsets.only(top: 30, bottom: 45),
                                            child: MaterialButton(
                                              padding: const EdgeInsets.all(17),
                                              color: const Color.fromARGB(255, 255, 255, 255),
                                              child: Text(
                                                "добавить".toUpperCase(),
                                                style: const TextStyle(fontSize: 14, color: Color(0xFF12141F)),
                                              ),
                                              shape: const RoundedRectangleBorder(
                                                side: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              onPressed: () async {
                                                debugPrint('onPressed');
                                                // platform = Provider
                                                //     .of<Data>(context, listen: false)
                                                //     .data['platform'].toString();

                                                if (_productsKey.currentState?.saveAndValidate() ?? false) {
                                                  debugPrint('Valid add product');

                                                  platform = Provider
                                                      .of<Data>(context, listen: false)
                                                      .data['platform'].toString();
                                                  debugPrint(platform);
                                                  if (_productsKey.currentState?.saveAndValidate() ?? false) {
                                                    debugPrint('Product added');
                                                    if (platform == 'android' || platform == 'ios') {
                                                      debugPrint(platform);
                                                      final bytes = File(productImage[0].path).readAsBytesSync();

                                                      debugPrint(bytes.runtimeType.toString());
                                                      setState(() {
                                                        encode64Product = base64.encode(bytes);
                                                      });

                                                      debugPrint(encode64Product);
                                                    } else {
                                                      debugPrint(platform);
                                                      bytes = productImage[0].bytes;

                                                      setState(() {
                                                        encode64Product = base64.encode(bytes!);
                                                      });
                                                    }
                                                    // debugPrint(userId);
                                                    print('category');
                                                    print(category);
                                                    // categoryId = categoriesName.where((o) => o == category) as String;
                                                    categoryId = (categoriesName.indexOf(category.toString()) + 1).toString();
                                                    print(categoryId);

                                                    dynamic currentProduct = Product(
                                                      id: id,
                                                      categoryId: categoryId,
                                                      category: category,
                                                      productId: productId,
                                                      productName: productName,
                                                      productImage: encode64Product,
                                                      productPrice: productPrice,

                                                    );
                                                    confirmDialog(context, currentProduct);


                                                    debugPrint(_productsKey.currentState?.value.toString());
                                                  } else {
                                                    debugPrint('Invalid');
                                                  }
                                                }
                                              }
                                            )),
                                      ]))
                                ]),
                              ])),
                        ),
                      ]),
                    )),
                drawer: const NavDrawerAdmin(),
              ));
        }
    );
  }
  addProduct(Product product) async {
    debugPrint('func addProduct registr');

    dynamic id = product.id;
    dynamic categoryId = product.categoryId;
    dynamic category = product.category;
    dynamic productId = product.productId;
    dynamic productName = product.productName;
    dynamic productPrice = product.productPrice;
    dynamic productImage = product.productImage;

    String apiUrl = baseUrl + "/test/add_product.php";

    var response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json, charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    }, body: {
      'id': id,
      'categoryId': categoryId,
      'category': category,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,

    });
    if (response.statusCode == 200) {
      debugPrint('success add product');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      final productJson = json.decode(response.body);

      dynamic data = Product.fromJson(productJson);

      return data;
    } else {
      debugPrint('error');
      throw Exception('We were not able to successfully download the json data.');
    }
  }

  Future confirmDialog(BuildContext context, product) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Добавить товар?'.toUpperCase(),
            textAlign: TextAlign.center,
            style: styleTextAlertDialog,
          ),
          actions: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(14),
                    color: const Color(0xFFE4E6FF),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Да'.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: styleTextAlertDialog,
                    ),
                    onPressed: () {
                      addProduct(product);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopAdmin()));
                    },
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(14),
                    color: const Color(0xFFE4E6FF),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Нет'.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: styleTextAlertDialog,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]))
          ],
        );
      },
    );
  }

}

