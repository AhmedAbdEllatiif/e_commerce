import 'package:e_commerce/screens/regeister_screen.dart';

import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:e_commerce/widgets/custom_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../appUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginEmail = "";
  String _loginPassword = "";
  FocusNode passwordFocusNode;
  bool showPassword = true;
  bool isLoading = false;

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

  bool checkFields() {
    return _loginEmail.trim() == "" || _loginPassword.trim() == "";
  }

  Future<bool> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _loginEmail, password: _loginPassword);

      if (userCredential != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showAlertDialog(
            title: 'Wrong e-mail', content: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showAlertDialog(
            title: 'Wrong Password',
            content: 'Wrong password provided for that user.');
      }
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
            actions: [
              FlatButton(
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          ),
        );
      },
    );
  }

  void submitLogin() async {
    setState(() {
      isLoading = true;
    });

    bool isLoggedIn = await loginUser();

    isLoggedIn
        ? setState(() {
            isLoading = false;
          })
        : setState(() {
            isLoading = false;
          });
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
                    margin: EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        Text(
                          "Welcome User,\nLogin to your account",
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
                        onChanged: (value) {
                          _loginEmail = value.trim();
                        },
                        onSubmitted: (value) {
                          _loginPassword = value;
                          passwordFocusNode.requestFocus();
                        },
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                      ),
                      CustomInputField(
                        hint: 'Password . . .',
                        isPasswordInput: true,
                        onChanged: (value) {
                          _loginPassword = value;
                        },
                        onSubmitted: (value) {
                          _loginPassword = value.trim();
                          submitLogin();
                        },
                        focusNode: passwordFocusNode,
                        isShowPassword: showPassword,
                        onShowPassword: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      CustomButton(
                        text: "Login",
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        borderColor: Colors.black,
                        isLoading: isLoading,
                        onClicked: () {
                          checkFields()
                              ? showAlertDialog(
                                  title: 'Required Fields',
                                  content: 'All fields are required')
                              : submitLogin();
                        },
                      ),
                    ],
                  ),
                  CustomButton(
                    text: "Create New Account",
                    onClicked: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                      print("Button Clicked");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Welcome User,\nLogin to your account",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,
                    ),
                  ],
                ),
              ),



              Column(// Login
                children: [
                  CustomInputField(hint: 'Email . . .'),
                  CustomInputField(hint: 'Password . . .'),
                  CustomButton(
                    text: "Login",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    onClicked: (){
                      print("Login Clicked");
                    },
                  ),
                ],
              ),


              CustomButton(
                text: "Create New Account",
                onClicked: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                  print("Button Clicked");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
