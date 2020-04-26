import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  String _date = "Not set";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    File _image;
    TextEditingController _captionController = TextEditingController();
    TextEditingController _numSeedsController = TextEditingController();
    String _name = '';
    int numSeeds = 0;


    void initState() {
      super.initState();
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
      print("Starting to submit");

      Navigator.pop(context);

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
                        labelText: 'Plant Name',
                      ),
                      onChanged: (input) => _name = input,
                    ),
                  ),



                  SizedBox(height: 20.0,),
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
                      onChanged: (input) => numSeeds = int.parse(input),
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
