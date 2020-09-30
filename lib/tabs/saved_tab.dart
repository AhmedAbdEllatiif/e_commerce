import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/appUtils.dart';
import 'package:e_commerce/screens/product_screen.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:e_commerce/widgets/saved_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final CollectionReference savedProductsRef = FireStoreReferences.savedProductsReference;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: savedProductsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {

                return ListView(
                  padding: EdgeInsets.only(top: 100.0, bottom: 12.0),
                  children: snapshot.data.docs.map((doc){

                   return GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ProductPage(
                                   productId: doc.id,
                                 )));
                       },
                     child: Container(
                        child: SavedItemCard(productId: doc.data()['${FireStoreConstants.id}'],),
                      ),
                   );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),



          CustomActionBar(
            title: 'Saved Products',
            hasBackArrow: false,
            hasTitle: true,
          )
        ],
      ),
    );
  }
}
