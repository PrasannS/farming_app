import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/main_screen.dart';
import 'package:farming_app/utils/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupWidget extends StatefulWidget {
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;


  @override
  void initState() {
    super.initState();
    nameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password length must be longer than 8 characters';
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

          ),
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
                          ),
                          onPressed: (){setState(() {

                          });},
                        ),
                        SizedBox(width: 90.0,),
                        Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(

                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 40.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: nameInputController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Full Name',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                                ),
                                validator: (input) {
                                  if (input.trim().length < 1) {
                                    return "Please input a valid name";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: emailInputController,

                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter your Email',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: passwordInputController,
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Enter your Password',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                    SizedBox(height: 40.0,),

                    GestureDetector(
                      onTap: () {
                        print("HELLO");
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then(
                                (currentUser) async {
                              Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                                "name":nameInputController.text,
                                "email":emailInputController.text,
                                "uid":currentUser.user.uid,
                              });
                            });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white
                        ),
                        child: Center(
                          child: Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          )
      ),
    );
  }
}
