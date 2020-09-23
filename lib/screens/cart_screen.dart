import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              CustomActionBar(
                cartNum: 5,
                title: 'Home',
                hasBackArrow: true,
                hasTitle: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
