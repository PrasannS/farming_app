import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProduceScreen extends StatefulWidget {
  ProduceScreen({Key key, this.postId}) : super(key: key);
  final String postId;
  @override
  _ProduceScreenState createState() => _ProduceScreenState();
}

class _ProduceScreenState extends State<ProduceScreen> {
  int amount = 1;
  DocumentSnapshot post;
  DocumentSnapshot user;
  String uid;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    FirebaseAuth.instance.currentUser().then((currentUser) {
      uid = currentUser.uid;
    });
    post = await Firestore.instance
        .collection('posts')
        .document(widget.postId)
        .get();
    DocumentSnapshot hold = await Firestore.instance
        .collection('users')
        .document(post.data['uid'])
        .get();
    setState(() {
      user = hold;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Material(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Container(
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                      child: Image.network(
                        post.data['url'],
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  top: 15.0,
                  left: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 15.0,
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post.data['type'].toString(),
                        style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.data['price'].toString(),
                        style:
                        TextStyle(fontSize: 40.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    user.data['name'],
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    user.data['address'],
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    post.data['desc'],
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        iconSize: 30.0,
                        onPressed: () {
                          if (amount > 0) {
                            setState(() {
                              amount--;
                            });
                          }
                        },
                      ),
                      Text(
                        amount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(() {
                            amount++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        //add to cart button
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xffFFD819),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      iconSize: 30.0,
                                      onPressed: () {
                                        List<dynamic> cartItems = user.data['cartItems'];
                                        List<dynamic> cartQuantity = user.data['cartQuantity'];
                                        bool alreadyInCart = false;
                                        if (cartItems != null) {
                                          for (int i = 0; i < cartItems.length; i++) {
                                            if (cartItems[i] == post.documentID) {
                                              cartQuantity[i] += amount;
                                              alreadyInCart = true;
                                              break;
                                            }
                                          }
                                        }
                                        if (!alreadyInCart) {
                                          cartItems.add(post.documentID);
                                          cartQuantity.add(amount);
                                        }
                                        Firestore.instance
                                            .collection('users')
                                            .document(uid)
                                            .updateData({
                                          'cartItems': cartItems,
                                          'cartQuantity': cartQuantity,
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.8)),
                          //color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.favorite_border,
                            size: 30.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
