import 'package:flutter/material.dart';

import '../appUtils.dart';

class TotalBottomBar extends StatelessWidget {

  final String totalPrice;


  TotalBottomBar({this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.09),
                spreadRadius: 1.0,
                blurRadius: 20.0),
          ]),


      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          ///Total text
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: Text(
              'Total',
              style: Constants.boldHeading,
            ),
          ),


          ///Total text
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: Text(
              '\$$totalPrice',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF1E00)
              ),
            ),
          ),


        ],

      ),
    );
  }
}
