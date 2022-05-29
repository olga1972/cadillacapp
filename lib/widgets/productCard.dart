import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    var productInfo;
    return Card(
        child: Column(
            children: [
              Image.asset(
                productInfo.image,
                // centerSlice: Rect.fromPoints(const Offset(50.0, 0.0), const Offset(0, 0)),
                fit: BoxFit.contain,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  Text(productInfo.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'CadillacSans',
                        color: Color(0xFF181C33),
                        height: 1.4, //line-height : font-size
                      )
                  ),
                  IconButton(
                    icon: SvgPicture.network(
                        'assets/images/add.svg',
                        currentColor: const Color(
                            0xFF12141F),
                        semanticsLabel: 'Icon plus',
                        height: 8.0
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                children: [
                  Text(productInfo.price,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 7.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'CadillacSans',
                        color: Color(0xFF181C33),
                        height: 1.4, //line-height : font-size
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 3),
                    child: const Icon(
                        Icons.currency_ruble),
                  )
                ],
              )
            ]
        )
    );
    // int categoryId = products[0].categoryId;
    // String category = products[0].category;
    // int id = products[0].id;
    // String name = products[0].name;
    // String image = products[0].image;
    // int price = products[0].price;
    // int quantity = products[0].quantity;


  }
}
