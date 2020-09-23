import 'package:e_commerce/appUtils.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final int cartNum;

  CustomActionBar({this.title, this.hasBackArrow,this.hasTitle, this.cartNum});

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    int _cartNum = cartNum ?? 0;
    bool _isCartEmpty = (_cartNum == 0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0)
          ],
          begin: Alignment(0,0),
          end: Alignment(0,1)

        )
      ),
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 40.0, bottom: 42.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            ///back arrow
            if (_hasBackArrow)
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: Dimension.small_box_dimen,
                  height: Dimension.small_box_dimen,
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('${AppUtils.images_dir}back_arrow.png'),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black),
                ),
              ),

            ///Title
            if(_hasTitle)
            Text(
              title ?? '',
              style: Constants.boldHeading,
            ),

            ///Cart
            GestureDetector(

              child: Container(
                width: Dimension.small_box_dimen,
                height: Dimension.small_box_dimen,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: _isCartEmpty
                        ? Colors.black
                        : Theme.of(context).accentColor),
                child: Text(
                  '$_cartNum',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage()));
              },
            )


          ],
        ));
  }
}
