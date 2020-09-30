import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/appUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedItemCard extends StatelessWidget {
  final String productId;
  static DocumentReference productDocRef;

  SavedItemCard({this.productId});

  @override
  Widget build(BuildContext context) {
    productDocRef =
        FireStoreReferences.productsReference.doc('$productId' ?? '0');

    return FutureBuilder<DocumentSnapshot>(
      future: productDocRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return LoadingSavedCard();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSavedCard();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (snapshot.data.exists) {
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
              height: 350.0,
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Stack(
                children: [
                  ///Product Image
                  Container(
                    height: 350.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: '${AppUtils.images_dir}place_holder.png',
                        image:
                            '${data['${FireStoreConstants.productImageUrl}']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  ///Texts(ProductName , Price)
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Product name
                          Text(
                            '${data['${FireStoreConstants.productName}']}' ??
                                'Product',
                            style: Constants.regularHeading,
                          ),

                          ///price
                          Text(
                            '\$${data['${FireStoreConstants.productPrice}']}' ??
                                '\$000',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return LoadingSavedCard();
      },
    );
  }
}





class LoadingSavedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      height: 350.0,
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Stack(
        children: [
          ///Product Image
          Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          ),

          ///Texts(ProductName , Price)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Product name
                  Text(
                    'Product',
                    style: Constants.regularHeading,
                  ),

                  ///price
                  Text(
                    '\$000',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
