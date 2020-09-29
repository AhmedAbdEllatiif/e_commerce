import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static const String images_dir = 'assets/';
}


class Dimension {
  static const double small_box_dimen = 42.0;
  static const double saved_box_dimen = 50.0;
}


class FireStoreConstants {
  static const String product_collection = 'Products';
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
