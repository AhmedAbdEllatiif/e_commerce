import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appUtils.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {

    CollectionReference collectionReference = FireStoreReferences.cartReference;

    return Scaffold(
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
  }
}
