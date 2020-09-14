import 'package:e_commerce/appUtils.dart';
import 'package:flutter/cupertino.dart';
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





class CustomInputField extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Function onShowPassword;
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final bool isPasswordInput;
  final bool isShowPassword;


  CustomInputField({this.hint,this.onChanged,this.onSubmitted,this.focusNode,
    this.inputAction,this.inputType,this.isPasswordInput,this.isShowPassword,this.onShowPassword});

  @override
  Widget build(BuildContext context) {

    bool _isPassword = isPasswordInput??false;
    bool _isShowPassword = isShowPassword??false;

    return Container(
      height: 50.0,
      margin: EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 24.0),
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200]
      ),
      child: TextField(
        textInputAction: inputAction,
        keyboardType : inputType,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
          obscureText: _isShowPassword,
        decoration: InputDecoration(
          icon: _isPassword? GestureDetector(
            onTap:onShowPassword ,
            child: Icon(
                Icons.remove_red_eye_outlined
            ),
          ) : Icon(Icons.email_outlined),
          hintText: hint??"Required Field. . .",
          border: InputBorder.none
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}




class MyScrollBehavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {

    return child;
  }
}