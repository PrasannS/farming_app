import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class PostPage extends StatefulWidget {
  PostPage({Key key, this.skill}) : super(key: key);
  final String skill;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  String currentUserId;
  QuerySnapshot posts;

  _submit(BuildContext context) async {
    print("Starting to submit");

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

  }

  getPosts() async {
    FirebaseAuth.instance.currentUser().then((value) {
      currentUserId = value.uid;
    });
    QuerySnapshot hold = await Firestore.instance.collection('posts').getDocuments();
    setState(() {
      posts = hold;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (posts == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No Plants to sell',
          ),
        ),
      );
    }
    else {
      List<DocumentSnapshot> myPlants = new List();
      for (int i = 0; i < posts.documents.length; i++) {
        if (posts.documents[i].data['uid'] == currentUserId) {
          myPlants.add(posts.documents[i]);
        }
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 30.0,
              color: Colors.black,
              onPressed: () => _submit(context),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: myPlants.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: myPlants[i].data['type'],
                onTap: () {
                  posts.documents[i].reference.updateData({
                    'produce': true,
                  });
                  setState(() {

                  });
                },
              );
            }),
      );
    }
  }

}
