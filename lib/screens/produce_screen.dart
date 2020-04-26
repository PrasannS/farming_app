import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

String currentPostID;

class ProduceScreen extends StatefulWidget {

  @override
  _ProduceScreenState createState() => _ProduceScreenState();
}

class _ProduceScreenState extends State<ProduceScreen> {

  int amount = 1;
  String desc;
  String name;
  double price;
  String url;
  String address;
  String type;
  String uid;

  loadData() async {
    await Firestore.instance.collection('posts').document(currentPostID).get().then((value) {
      desc = value.data['desc'];
      price = value.data['price'];
      url = value.data['url'];
      type = value.data['type'];
      uid = value.data['uid'];
    });
    await Firestore.instance.collection('users').document(uid).get().then((value) {
      name = value['name'];
      address = value['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('posts').document(currentPostID).get(),
      builder: (context, snapshot) {
        loadData();
        if(snapshot.connectionState!=ConnectionState.done){
          return Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(),
          );
        }
        else{
          return Scaffold(
            body: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: 300.0,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                          child: Image.network(snapshot.data['url'], fit: BoxFit.cover,)
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      left: 10.0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 10.0,
                      child: IconButton(
                        icon: Icon(Icons.add, size: 35.0, color: Colors.white,),
                        onPressed:(){
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data['type'].toString(), style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10.0,),
                      Text(snapshot.data['name'].toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),),
                      SizedBox(height: 10.0,),
                      Text(address.toString(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
                      SizedBox(height: 10.0,),
                      Text(
                        snapshot.data['desc'].toString(),
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        children: [
                          IconButton(icon: Icon(Icons.remove_circle), iconSize: 30.0, onPressed: (){
                            if(amount>0) {
                              amount--;
                            }
                          },
                          ),
                          Text(amount.toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),),
                          IconButton(icon: Icon(Icons.add_circle), iconSize: 30.0, onPressed: (){
                            amount++;
                          },
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0,),
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
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 10.0,),
                                        Text('Add to Cart', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                                        SizedBox(width: 30.0,),
                                        IconButton(icon: Icon(Icons.add_circle_outline), iconSize: 30.0,
                                          onPressed: () {
                                            var list = List<String>();
                                            list.add(currentPostID);
                                            list.add(amount.toString());
                                            Firestore.instance.collection('users').document(userid).setData({'cart': FieldValue.arrayUnion(list)});
                                            amount = 1;
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.8)),
                              //color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(Icons.favorite_border, size: 30.0,),
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
      },
    );
  }
}
