import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/cart_item_card.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/saved_item_card.dart';
import 'package:e_commerce/widgets/total_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appUtils.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference collectionReference = FireStoreReferences.cartReference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (context, snapshot) {
                  ///Connection is waiting
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  ///Connection is active
                  if (snapshot.connectionState == ConnectionState.active) {
                    return Container(
                      child: ListView(
                        padding: EdgeInsets.only(top: 150.0, bottom: 50.0),
                        children: snapshot.data.documents
                            .map<Widget>((DocumentSnapshot document) {
                          return Container(
                            child: CartItemCard(
                              productId: document.id,
                              size:
                                  '${document.data()[FireStoreConstants.size_doc]}',
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }

                  ///Default view
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

              ///ActionBar
              CustomActionBar(
                title: 'Cart',
                hasBackArrow: true,
                hasTitle: true,
              ),

              ///Total price
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: TotalBottomBar(
                  totalPrice: '150',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
*
* return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: EdgeInsets.only(top: 300.0),
                      child: Text(
                        'Loading',
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.active) {
                    return Container(
                      margin: EdgeInsets.only(top: 150.0),
                      child: new ListView(
                        children: snapshot.data.documents
                            .map<Widget>((DocumentSnapshot document) {
                          return new ListTile(
                            title: new Text("${document.data()['size']}"),
                            subtitle: new Text("test"),
                          );
                        }).toList(),
                      ),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(top: 300.0),
                    child: Text(
                      'Nothing to display',
                    ),
                  );
                },
              ),
              CustomActionBar(
                title: 'Cart',
                hasBackArrow: true,
                hasTitle: true,
              )
            ],
          ),
        ),
      ),
    );
    *
    * */
