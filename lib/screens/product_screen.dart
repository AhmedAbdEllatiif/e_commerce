import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appUtils.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _productId;

  @override
  void initState() {
    _productId = widget.productId ?? 'UnKnown productId';
    super.initState();
  }

  DocumentReference documentRef;

  @override
  Widget build(BuildContext context) {
    documentRef = FirebaseFirestore.instance
        .collection('${FireStoreConstants.product_collection}')
        .doc('${widget.productId}');

    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: documentRef.get(),
              builder: (context, snapshot) {
                ///Snapshot has error
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                ///Is Done
                ///Show the list of Products
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Scaffold(

                    body: mainView(context, data),
                  );
                }

                ///loading Status
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),

            ///Action bar
            CustomActionBar(
              cartNum: 2,
              hasBackArrow: true,
              hasTitle: false,
              hasBackground: false,
            )
          ],
        ),
      ),
    );
  }
}

ListView mainView(context,data) {
  return ListView(
    children: [
      Container(
        height: 400,

        child: PageView(
          children: [
            for(var i=0 ; i<data['images'].length; i++ )
              Container(
                child: FadeInImage.assetNetwork(
                  placeholder: '${AppUtils.images_dir}place_holder.png',
                  image: data['images'][i],
                  fit: BoxFit.cover,
                ),
              )
          ],
        )
      ),

      ///Product Name
      Padding(
        padding: const EdgeInsets.only(
           top: 24.0,
            right: 24.0,
          left: 24.0,
          bottom: 4.0
        ),
        child: Text(
          '${data['name']}',
          style: Constants.boldHeading,
        ),
      ),

      ///price
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0),
        child: Text(
          '\$${data['price']}',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),

      ///desc
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
        child: Text(
          '\$${data['desc']}',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),


    ],
  );
}
