import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database{

  FirebaseUser user;

  createUser(String name, String email, String password, String url) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      Firestore.instance.collection('users').document(value.user.uid).setData({
        'name': name,
        'url': url,
        'email': email,
        'posts': [],
        'rating': 0,
      });
      user = value.user;
    });
  }

  createPost(double price, int fresh, AssetImage image, String imageURL, int count, int day, int month, int year, AssetImage img) async {
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
    });
    Firestore.instance.collection('users').document(user.uid).setData({
      'posts': 'posts'+uploadRef.documentID,
    });
  }

  accessEntirePost() {
    return Firestore.instance.collection('posts');
  }

  returnAllElement(String data, String collection, int index) async {
    return StreamBuilder(
      stream: accessEntirePost().snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState!=ConnectionState.done) {
          return Text('Loading');
        }
        else{
          var docs = snapshot.data;
          return Container(
            child: ListView.builder(
              itemBuilder: (context, int i) {
                return Container(
                  //insert widget here, to access data use docs[i][insert the element you want]
                );
              }
            ),
          );
        }
      }
    );
  }
}