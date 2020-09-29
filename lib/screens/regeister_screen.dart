import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:e_commerce/widgets/custom_scroll_behavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appUtils.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

bool isLoading = false;
String  btnText = "Create Account";

class _RegisterPageState extends State<RegisterPage> {


 String _registeredEmail = "";
 String _registeredPassword = "";
 FocusNode passwordFocusNode;

  Future<bool> registerAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeredEmail,
          password: _registeredPassword
      );
      if(userCredential != null){
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDialog(title: 'Weak Password',content: 'You use multiple characters');
        //print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showAlertDialog(title: 'Already User',content: 'Go to Login page');
        //print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }


  Future<void> showAlertDialog({String title, String content}) async {
    return showDialog(
      context: context,
      //barrierDismissible: false, //To make Dismissible
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: AlertDialog(
            title: Text(title ?? "Error"),
            content: Container(
              child: Text(content ?? "Error has happened"),
            ),
            actions: [FlatButton(onPressed: () {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              }, child: Text("Close"))],
          ),
        );
      },
    );
  }
bool showPassword = true;

  bool checkFields(){
    return _registeredPassword.trim() == ""||
        _registeredPassword.trim() =="" ;
  }

  void submitNewUser() async {

    setState(() {
      isLoading = true;
    });

     bool isSubmitted = await registerAccount();

    isSubmitted?  setState(() {
      isLoading = false;
      btnText = "Succeed....";

    }) :  setState(() {
      isLoading = false;

    });
  }

 @override
 void initState() {
   passwordFocusNode = FocusNode();
   super.initState();
 }

 @override
 void dispose() {
   passwordFocusNode.dispose();
   super.dispose();
 }

 Widget build(BuildContext context) {
   return Scaffold(
     body: ScrollConfiguration(
       behavior: MyScrollBehavior(),
       child: SingleChildScrollView(
         //physics: NeverScrollableScrollPhysics(),
         child: ConstrainedBox(
           constraints: BoxConstraints(
             minWidth: MediaQuery.of(context).size.width,
             minHeight: MediaQuery.of(context).size.height,
           ),
           child: IntrinsicHeight(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               children: <Widget>[

                 Container(
                   //Heading
                   margin: EdgeInsets.only(top: 24.0),
                   child: Column(
                     children: [
                       Text(
                         "Create New Account",
                         textAlign: TextAlign.center,
                         style: Constants.boldHeading,
                       ),
                     ],
                   ),
                 ),
                 Column(
                   // Login
                   children: [
                     CustomInputField(
                       hint: 'Email . . .',
                       onChanged: (value){
                         _registeredEmail = value;
                       },
                       onSubmitted: (value){
                         _registeredEmail = value;
                         passwordFocusNode.requestFocus();
                       },
                       inputAction: TextInputAction.next,
                       inputType: TextInputType.emailAddress,
                     ),
                     CustomInputField(
                       hint: 'Password . . .',
                       isPasswordInput: true,
                       onChanged: (value){
                         _registeredPassword = value;
                       },
                       onSubmitted: (value){
                         _registeredPassword = value;
                         submitNewUser();
                       },
                       focusNode: passwordFocusNode,
                       isShowPassword: showPassword
                       ,onShowPassword: (){
                         setState(() {
                           showPassword = !showPassword;
                         });
                       },
                     ),
                     Container(
                       margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                       child: CustomButton(
                         text: "Create Account",
                         backgroundColor: Colors.black,
                         textColor: Colors.white,
                         borderColor: Colors.black,
                         isLoading: isLoading,
                         onClicked: () {
                           checkFields() ? showAlertDialog(
                             title: 'Required Fields',
                             content: 'All fields are required'
                           ) : submitNewUser();
                         },
                       ),
                     ),
                   ],
                 ),
                 Container(
                   margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                   child: CustomButton(
                     text: "Back To Login",
                     onClicked: () {
                       Navigator.pop(context);
                     },
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
 }




 /* Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomPadding : false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //Heading
                margin: EdgeInsets.only(top: 24.0),
                child: Column(
                  children: [
                    Text(
                      "Create New Account",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,
                    ),
                  ],
                ),
              ),
              Column(
                // Login
                children: [
                  CustomInputField(
                      hint: 'Email . . .',
                      onChanged: (value){
                        _registeredEmail = value;
                      },
                    onSubmitted: (value){
                        _registeredEmail = value;
                        passwordFocusNode.requestFocus();
                    },
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomInputField(
                    hint: 'Password . . .',
                    isPasswordInput: true,
                    onChanged: (value){
                      _registeredPassword = value;
                    },
                    onSubmitted: (value){
                      _registeredPassword = value;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  CustomButton(
                    text: "Create Account",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    isLoading: isLoading,
                    onClicked: () {
                      checkFields() ? showAlertDialog() : registerAccount();
                    },
                  ),
                ],
              ),
              CustomButton(
                text: "Back To Login",
                onClicked: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
