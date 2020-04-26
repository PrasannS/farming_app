import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/produce_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/screens/produce_screen.dart';

class Database{

  FirebaseUser user;

  createPost(double price, int fresh, AssetImage image, String imageURL, int count, int day, int month, int year, AssetImage img, bool produce) async {
    user = await FirebaseAuth.instance.currentUser();
    DocumentReference uploadRef = await Firestore.instance.collection('posts').add({
      'uid': user.uid,
      'fresh': fresh,
      'price': price,
      'url': imageURL,
      'units': count,
      'day': day,
      'month': month,
      'year': year,
      'produce': produce,
    });
    Firestore.instance.collection('users').document(user.uid).setData({
      'posts': 'posts'+uploadRef.documentID,
    });
  }

  dataPost(bool isProduce) {
    return FutureBuilder(
      future: Firestore.instance.collection('posts').getDocuments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else {
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return Container(
            child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int i){
                  if(docs[i]['produce']==isProduce){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 7.0, // has the effect of softening the shadow
                              spreadRadius: 1.0, // has the effect of extending the shadow
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 150.0,
                                    width: 150.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(docs[i]['url'], fit: BoxFit.cover, height: 30,
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      currentPostID = docs[i].documentID;
                                      print('Post ID: '+currentPostID);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProduceScreen()),
                                      );
                                    },
                                    child: Container(
                                      width: 142,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(docs[i]['type'], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
                                            SizedBox(height: 10.0,),
                                            Text(docs[i]['desc'], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),),
                                            SizedBox(height: 15.0,),
                                            Text('\$${docs[i]['price']}/gram', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
                                            SizedBox(height: 15.0,),
                                            Text('10 - 20 days to grow', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    );
                  }
                  else{
                    return null;
                  }
                }
            ),
          );
        }
      }
    );
  }
}