
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cadillac/widgets/productCard.dart';


class ProductsList {
  ProductsList({Key? key});


  final List<String> categories = ['футболки', 'худи', 'блокноты', 'наклейки'];


  @override
  Widget build (BuildContext context, int index) {
    // int categoryId = productsList[0].categoryId;
    // String category = productsList[0].category;
    // int id = productsList[0].id;
    // String name = productsList[0].name;
    // String image = productsList[0].image;
    // int price = productsList[0].price;
    // int quantity = productsList[0].quantity;
    //
    // List<ProductsList> filter = [];
    // filter.addAll(productsList);
    //
    // filter.where((f) => f.categoryId == 1).toList();
    //
    // print(filter);


    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // height: 100,
            margin: const EdgeInsets.only(top: 43.0, bottom: 43.0),
            // color: Colors.transparent,
            child: Row(
              children: [
              Expanded(
              flex: 1,
              child: Container(
                  height: 172,
                  margin: const EdgeInsets.only(right: 25.0),
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  alignment: Alignment.center,
                  child: Text(categories[index].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'CadillacSans',
                        color: Colors.white,
                        height: 1.4, //line-height : font-size
                      )
                  )
              ),
            ),
          ]
          )
        );

        }
    );
  }
}


