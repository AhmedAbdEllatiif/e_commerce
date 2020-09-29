import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Hello Home Tab"),
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
