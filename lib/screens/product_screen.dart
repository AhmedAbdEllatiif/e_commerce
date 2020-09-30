import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/images_swipe.dart';
import 'package:e_commerce/widgets/sizes_boxes.dart';

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
  final globalKey = GlobalKey<ScaffoldState>();
  String _productId;
  dynamic _selectedSize;
  DocumentReference productDocReference;

  @override
  void initState() {
    _productId = widget.productId ?? 'UnKnown productId';
    productDocReference =
        FireStoreReferences.productsReference.doc('$_productId');
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: productDocReference.get(),
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
                    key: globalKey,
                    body: mainView(buildContext, data),
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
              hasBackArrow: true,
              hasTitle: false,
              hasBackground: false,
            )
          ],
        ),
      ),
    );
  }

  ListView mainView(context, data) {
    List<dynamic> imagesList = data['images'];
    List<dynamic> sizeList = data['size'];

    return ListView(
      children: [
        ///Page view of product images
        ImagesSwipe(imagesList: imagesList),

        ///Product Name
        Container(
          padding: const EdgeInsets.only(
              top: 24.0, right: 24.0, left: 24.0, bottom: 4.0),
          child: Text(
            '${data['name']}',
            style: Constants.boldHeading,
          ),
        ),

        ///price
        Container(
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
        Container(
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

        ///Select size text
        Container(
          margin: EdgeInsets.only(top: 15.0),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
          child: Text(
            'Select Size',
            style: Constants.regularHeading,
          ),
        ),

        ///SizesBoxes
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 19.0),
          child: SizesBoxes(
            sizeList: sizeList,
            onSizeChanged: (size) {
              _selectedSize = size;
            },
          ),
        ),

        ///Container ==> row of add to cart & save product
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 40.0),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 19.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///Save button
              SaveButton(
                productId: _productId,
              ),

              ///Add to cart button
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: CustomButton(
                    height: 65.0,
                    text: 'Add To Cart',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onClicked: () async {
                      await addToCart();
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ///To add product to the cart
  Future addToCart() {
    return FireStoreReferences.cartReference
        .doc(_productId)
        .set({'${FireStoreConstants.size_doc}': _selectedSize ?? -1})
        .then((value) => showSnackBar('Product Added To Cart'))
        .catchError((error) => showSnackBar('$error'));
  }

  ///To show snackBar with message
  void showSnackBar(String content) {
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$content")));
    globalKey.currentState.showSnackBar(SnackBar(content: Text("$content")));
  }
}







class SaveButton extends StatefulWidget {
  final String productId;

  SaveButton({this.productId});

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  String _productId;
  bool isSaved = false;

  @override
  void initState() {
    _productId = widget.productId ?? "-1";
    changeButtonColorWithSavedStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        savedProduct();
        //showSnackBar("This is Snack bar");
      },
      child: Container(
          child: Image(
            width: 13.0,
            height: 22.0,
            image: AssetImage('${AppUtils.images_dir}bookmark.png'),
            color: isSaved ? Colors.white : Colors.grey,
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          width: Dimension.saved_box_dimen,
          height: Dimension.saved_box_dimen,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isSaved ? Color(0xFFFF1E00) : Colors.grey.withOpacity(0.5),
          )),
    );
  } //build

  ///To save a product
  Future savedProduct() {
    return FireStoreReferences.savedProductsReference
        .doc(_productId)
        .get()
        .then((value) {
      if (value.exists) {
        value.reference.delete();
      } else {
        value.reference.set({'${FireStoreConstants.id}': _productId ?? "-1"});
      }
      changeButtonColorWithSavedStatus();
    }).catchError((error) => print('$error'));
  }

  ///To save a product
  Future changeButtonColorWithSavedStatus() {
    return FireStoreReferences.savedProductsReference
        .doc(_productId)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          isSaved = true;
        });
      } else {
        setState(() {
          isSaved = false;
        });
      }
    });
  }
}
