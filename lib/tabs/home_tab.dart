import 'package:e_commerce/appUtils.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  final CollectionReference _productsRef = FirebaseFirestore.instance.collection("Products");


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(

        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
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
              if(snapshot.connectionState == ConnectionState.done){
              return ListView(
                padding: EdgeInsets.only(
                  top: 100.0,
                  bottom: 12.0
                ),
                children: snapshot.data.docs.map((doc) {
                  return Container(
                    child: ProductCard(
                      imgUrl: '${doc.data()['url']}',
                      name: '${doc.data()['name']}',
                      price: '${doc.data()['price']}',
                    ),
                  );
                }).toList(),
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
          CustomActionBar(
            cartNum: 3,
            title: 'Home',
            hasBackArrow: false,
            hasTitle: true,
          )
        ],
      ),
    );
  }
}
