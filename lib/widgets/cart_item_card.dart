import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/appUtils.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {

  final String productId;
  final String size;


  CartItemCard({this.productId,this.size});


  static  DocumentReference productDocRef;



  @override
  Widget build(BuildContext context) {
    productDocRef =
        FireStoreReferences.productsReference.doc('$productId' ?? '0');


    return FutureBuilder<DocumentSnapshot>(
      future: productDocRef.get(),
      builder: (context, snapshot) {
        
        
        
        if(snapshot.connectionState == ConnectionState.waiting){
          ///loading Status
          return LoadingCard();
        }
        
        ///Snapshot has error
        if (snapshot.hasError) {
          return Center(
              child: Text("Error: ${snapshot.error}"),
          );
        }
        
        

        ///Is Done
        ///Show the list of Products
        if (snapshot.connectionState == ConnectionState.done) {
          if(snapshot.data.exists){

          Map<String, dynamic> data = snapshot.data.data();


          return Container(

              margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Product Image

                  Container(
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                      child: FadeInImage.assetNetwork(
                        width: 100.0,
                        height: 100.0,
                        placeholder: '${AppUtils.images_dir}place_holder.png',
                        image: '${data['${FireStoreConstants.productImageUrl}']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  ///Column of productName , price , size
                  Container(
                    margin: EdgeInsets.only(left: 15.0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ///ProductName text
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                          child: Text(
                            '${data['name']}' ?? "Product Name",
                            style: Constants.regularHeading,
                          ),
                        ),


                        ///Price text
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                          child: Text(
                            '\$${data['price']}'??'\$000',
                            style: Constants.priceStyle,
                          ),
                        ),


                        ///size text
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                          child: Text(
                            'Size - $size'?? 'Size - 00',
                            style: Constants.regularDarkText,
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
          );

          }
        }


        ///loading Status
        return LoadingCard();

      },
    );
  }
}



class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///Product Image

        Container(
        height: 100.0,
        width: 100.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),



          ///Column of productName , price , size
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Column(
              children: [

                ///ProductName text
                Container(
                  padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                  child: Text(
                    "Product Name",
                    style: Constants.regularHeading,
                  ),
                ),


                ///Price text
                Container(
                  padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                  child: Text(
                    '\$000',
                    style: Constants.priceStyle,
                  ),
                ),


                ///size text
                Container(
                  padding: EdgeInsets.only(bottom: 10.0,top: 5.0,left: 5.0,right: 5.0),
                  child: Text(
                   'Size - 00',
                    style: Constants.regularDarkText,
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );

  }
}
