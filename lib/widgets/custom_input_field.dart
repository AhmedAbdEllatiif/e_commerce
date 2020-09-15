import 'package:flutter/material.dart';

import '../appUtils.dart';

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
