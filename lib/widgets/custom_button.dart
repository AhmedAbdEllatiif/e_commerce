import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Function  onClicked;
  final bool isLoading;

  CustomButton({this.text,this.backgroundColor,this.textColor,this.borderColor,this
      .isLoading, this.onClicked});

  @override
  Widget build(BuildContext context) {

    bool _isLoading = isLoading?? false;

    return GestureDetector(
      onTap: onClicked,
      child: Center(
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          decoration: BoxDecoration(
              color: backgroundColor??Colors.transparent,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: borderColor??Colors.black,
                width: 2.0,
              )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: !_isLoading,
                child: Text(
                  text??"",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: textColor??Colors.black
                  ),
                ),
              ),
              SizedBox(
                  height:30.0 ,
                  width: 30.0,
                  child: Visibility(
                      visible: _isLoading,
                      child: CircularProgressIndicator()
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


