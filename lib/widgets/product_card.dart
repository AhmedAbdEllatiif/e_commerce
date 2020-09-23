import 'dart:ui';

import 'package:e_commerce/appUtils.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String price;

  ProductCard(
      {@required this.imgUrl, @required this.name, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0)
      ),
      height: 350.0,
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
/*
*    child: Stack(
          children: [
            ///image
            Image(
                image: NetworkImage(imgUrl),
                fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Product name
                  Text(
                    '$name',
                    style: Constants.boldHeading,
                  ),

                  ///price
                  Text(
                    '#$price',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),

                ],
              ),
            )

          ],

        ),*/
