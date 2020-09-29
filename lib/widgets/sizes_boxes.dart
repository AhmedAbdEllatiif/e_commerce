import 'package:flutter/material.dart';

import '../appUtils.dart';

class SizesBoxes extends StatefulWidget {

 final List<dynamic> sizeList;
 final Function(dynamic size) onSizeChanged;


  SizesBoxes({@required this.sizeList,this.onSizeChanged});

  @override
  _SizesBoxesState createState() => _SizesBoxesState();
}

class _SizesBoxesState extends State<SizesBoxes> {
  List<dynamic> _sizeList;
  int _selectedSize;

  @override
  void initState() {
    _sizeList = widget.sizeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(int i=0; i < _sizeList.length; i++)
          GestureDetector(
            onTap: (){
              setState(() {
                _selectedSize = i;
                widget.onSizeChanged(_sizeList[i]);
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: Dimension.small_box_dimen,
              height: Dimension.small_box_dimen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _selectedSize == i ?
               Theme.of(context).accentColor : Colors.grey.withOpacity(0.5),
              ),
              child: Text(
                '${_sizeList[i]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: _selectedSize == i ?
                  Colors.white : Colors.grey.shade700,
                ),
              ),

            ),
          ),
      ],
    );
  }
}
