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



  File _image;
  TextEditingController _captionController = TextEditingController();
  String _caption = '';
  String description="Freshly grown red tomatoes that taste like red tomatos! Very juicy and fresh!";

  void initState() {
    super.initState();
  }


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });

    await uploadImage();
  }

  Future uploadImage() async {

  }



  _submit(BuildContext context) async {
    print("Starting to submit");

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: getImage,
                    child: Container(
                      height: width,
                      width: width,
                      color: Colors.grey[300],
                      child: _image == null
                          ? Icon(
                        Icons.add_a_photo,
                        color: Colors.white70,
                        size: 150.0,
                      )
                          : Image(
                        image: FileImage(_image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      controller: _captionController,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Caption',
                      ),
                      onChanged: (input) => description = input,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

}

/*
FlatButton(
        child: Text('Take PICTURE'),
        onPressed:(){
          getImage();
          _submit(context);
        },
      ),

 */