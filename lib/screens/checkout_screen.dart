import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/produce_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<dynamic> cartItems;
  List<dynamic> cartQuantity;
  String userId;
  QuerySnapshot allPosts;
  DocumentSnapshot currentUser;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  Future<QuerySnapshot> loadDatabase() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      userId = value.uid;
    });
    currentUser =
        await Firestore.instance.collection('users').document(userId).get();
    QuerySnapshot hold =
        await Firestore.instance.collection('posts').getDocuments();
    setState(() {
      allPosts = hold;
    });
  }

  final round = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    double totalCost = 0;
    if (allPosts == null) {
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    } else {
      List<dynamic> cartItems = currentUser.data['cartItems'];
      List<dynamic> cartQuantity = currentUser.data['cartQuantity'];
      return Scaffold(
        backgroundColor: Colors.black26,
        body: Column(
          children: [
            Container(
              height: 625,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 40.0,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Spacer(),
                      Text(
                        'Shopping Cart',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.restore_from_trash,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext context, int i) {
                            print(i);
                            int postIndex = 0;
                            for (int j = 0;
                                j < allPosts.documents.length;
                                j++) {
                              if (cartItems[i] ==
                                  allPosts.documents[j].documentID) {
                                postIndex = j;
                                break;
                              }
                            }
                            double cost =
                                allPosts.documents[postIndex].data['price'] *
                                    cartQuantity[i];

                            print('print');
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      blurRadius:
                                          7.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          1.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        3.0, // horizontal, move right 10
                                        3.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                  borderRadius: new BorderRadius.circular(30.0),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 150.0,
                                            width: 150.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.network(
                                                allPosts.documents[postIndex].data['url'].toString(),
                                                fit: BoxFit.cover,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProduceScreen(
                                                          postId: allPosts.documents[postIndex]
                                                              .documentID,
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              width: 142,
                                              child: Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allPosts.documents[postIndex].data['type']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          round
                                                              .format(cost)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price: ',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$${round.format(totalCost)}',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Icon(
              Icons.keyboard_arrow_up,
              size: 40.0,
              color: Colors.white,
            ),
            Text(
              'Purchase',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      );
    }
  }
}
