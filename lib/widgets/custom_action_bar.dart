import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/appUtils.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;


  CustomActionBar({this.title, this.hasBackArrow,this.hasTitle,this.hasBackground});

  @override
  _CustomActionBarState createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {

  int totalItemsCount = 0;

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow ?? false;
    bool _hasTitle = widget.hasTitle ?? true;

    bool _hasBackground = widget.hasBackground ?? true;




    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          gradient: _hasBackground ? LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0)
            ],
            begin: Alignment(0,0),
            end: Alignment(0,1)

          ): null
        ) ,
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
                widget.title ?? '',
                style: Constants.boldHeading,
              ),

              ///Cart
              GestureDetector(
                child: StreamBuilder(
                    stream: userRef
                        .doc(user.uid)
                        .collection('${FireStoreConstants.cart_collection}')
                        .snapshots(),
                    builder: (context,snapShot){
                      if(snapShot.connectionState == ConnectionState.active){
                        List _docs = snapShot.data.docs;
                        totalItemsCount = _docs.length;
                      }

                      return Container(
                        width: Dimension.small_box_dimen,
                        height: Dimension.small_box_dimen,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: totalItemsCount > 0
                                ? Theme.of(context).accentColor
                                : Colors.black
                        ),
                        child: Text(
                          '$totalItemsCount' ?? "0",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      );
                    }
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage()));
                },
              )

            ],
          )),

    );
  }


   CollectionReference userRef = FirebaseFirestore.instance
        .collection('${FireStoreConstants.users_collection}');

   User  user = FirebaseAuth.instance.currentUser;
}
