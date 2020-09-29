import 'dart:ui';

import 'package:e_commerce/appUtils.dart';
import 'package:e_commerce/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String price;
  final String productId;

  ProductCard(
      {@required this.imgUrl, @required this.name, @required this.price,@required this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0)
      ),
      height: 350.0,
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Stack(
        children: [

          ///Product Image
          Container(
            height: 350.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage.assetNetwork(
                placeholder: '${AppUtils.images_dir}place_holder.png',
                image: imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          ///Texts(ProductName , Price)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Product name
                  Text(
                    '$name',
                    style: Constants.regularHeading,
                  ),

                  ///price
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
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
