import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static const String images_dir = 'assets/';
}


class Dimension {
  static const double small_box_dimen = 42.0;
  static const double saved_box_dimen = 65.0;
}


class FireStoreConstants {
  static const String product_collection = 'Products';
  static const String users_collection = 'Users';
  static const String cart_collection = 'Cart';
  static const String size_doc = 'size';
}


class FireStoreReferences{
  ///Current user of fireBase
  static User user = FirebaseAuth.instance.currentUser;

  ///Reference on Cart collection of current user id
  static CollectionReference cartReference = FirebaseFirestore.instance
      .collection('${FireStoreConstants.users_collection}')
      .doc(user.uid)
      .collection('${FireStoreConstants.cart_collection}');

  ///Reference on Users collection
  static CollectionReference usersReference = FirebaseFirestore.instance
      .collection('${FireStoreConstants.users_collection}');

  ///Reference on Products collection
  static CollectionReference productsReference = FirebaseFirestore.instance
      .collection('${FireStoreConstants.product_collection}');

}



class Constants {
  static const regularHeading = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );


  static const boldHeading = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );

  static const regularDarkText = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );
}
