import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  String _date = "Not set";
  String currentUserId;
  DateTime _plantedDate;



  File _image;
  TextEditingController _captionController;
  TextEditingController _numSeedsController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  String _name = '';
  int numSeeds = 0;


  void initState() {
    super.initState();
    _captionController = new TextEditingController();
    _numSeedsController = new TextEditingController();
    _descriptionController = new TextEditingController();
    _priceController = new TextEditingController();
    loadInfo();
  }

  loadInfo() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        currentUserId = value.uid;
      });
    });

  }

  Future uploadImage() async {

  }


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });

    await uploadImage();
  }


  _submit(BuildContext context) async {
    DocumentReference added = await Firestore.instance.collection('posts').add({
      'desc': _descriptionController.text.toString(),
      'datePlanted': _plantedDate,
      'produce': false,
      'planted': false,
      'uid': currentUserId,
      'type': _captionController.text.toString(),
      'price': double.parse(_priceController.text.toString()),
      'units': int.parse(_numSeedsController.text.toString()),
      'url': 'placeholder',
      'watered': DateTime.utc(2000),
    });
    DocumentSnapshot currentUser = await Firestore.instance.collection('users').document(currentUserId).get();
    List<dynamic> currentPosts = currentUser.data['posts'];
    if (currentPosts==null)
      currentPosts = [];
    currentPosts.add(added.documentID);
    Firestore.instance.collection('users').document(currentUserId).updateData({
      'posts': currentPosts,
    });
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
      if (currentUserId == null) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      else {
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
                  //height: MediaQuery.of(context).size.height,
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
                            labelText: 'Plant Name',
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: _descriptionController,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Date Planted', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
                      SizedBox(height: 20.0,),


                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                                print('confirm $date');
                                _plantedDate = date;
                                _date = '${date.year} - ${date.month} - ${date.day}';
                                setState(() {});
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                          color: Colors.teal,
                                        ),
                                        Text(
                                          " $_date",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "  Change",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),

                      SizedBox(height: 20.0,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 75.0),
                        child: TextField(
                          controller: _numSeedsController,
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Number of Seeds',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 75.0),
                        child: TextField(
                          controller: _priceController,
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
        );
      }
  }
}
