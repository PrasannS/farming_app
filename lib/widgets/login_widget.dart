import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/entry_screen.dart';
import 'package:farming_app/screens/main_screen.dart';
import 'package:farming_app/utils/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  int pageIndex = 0;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  final GlobalKey<FormState> _loginFormKey = new GlobalKey();

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(

            ),
            //padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios
                            ),
                            onPressed: (){setState(() {
                            });
                            },
                          ),
                          SizedBox(width: 90.0,),
                          Text(
                            'Login',
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
                                  controller: emailInputController,
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
                                    hintText: 'Enter your Email',
                                    hintStyle: StyleConstants.loginHintTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10.0),
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
                          print("LOGIN ATTEMPTED");
                          if (_loginFormKey.currentState.validate()) {
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then(
                                    (currentUser) {
                                  Firestore.instance.collection('users').document(currentUser.user.uid).get().then(
                                          (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => (MainPage())),
                                        );
                                      });
                                }
                            );
                          }
                        },

                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
            )
        ),
      ),
    );
  }
}
