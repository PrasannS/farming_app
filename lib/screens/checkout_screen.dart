import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/screens/produce_screen.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  List<dynamic> inCart;
  List<String> quantity;

  Future<QuerySnapshot> loadDatabase() async {
    quantity = new List<String>();
    print("LOAD");
    await Firestore.instance.collection('users').document(userid).get().then((value) {
      print("TEST1");
      inCart = value.data['cart'];
      for(int i=1;i<value.data['cart'].length;i+=2){
        quantity.add(value.data['cart'][i].toString());
      }
    });
    for(int i=0;i<inCart.length;i+=2){
      print("TEST2");
      await Firestore.instance.collection('posts').document(inCart[i]).get().then((value) {
      });
    }
    QuerySnapshot query = await Firestore.instance.collection('posts').getDocuments();

    print("QUERY" + query.toString());

    return Firestore.instance.collection('posts').getDocuments();
  }

  final round = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    double totalCost = 0;
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [


          Container(
            height: 625,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 40.0,),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Spacer(),
                    Text('Shopping Cart', style: TextStyle(fontSize: 30.0),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.restore_from_trash, size: 40.0,),
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                      future: loadDatabase(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState!=ConnectionState.done){
                          if(snapshot.hasError){
                            print(snapshot.error);
                          }
                          return Scaffold(
                            body: CircularProgressIndicator(),
                          );
                        }
                        else {
                          int cartLength;
                          if(inCart==null){
                            cartLength = 0;
                          }
                          if(inCart!=null){
                            cartLength = inCart.length;
                          }
                          List<DocumentSnapshot> cart = new List<DocumentSnapshot>();
                          print(snapshot.data);
                          for(int i=0;i<cartLength;i+=2){
                            cart.add(snapshot.data.documents[i]);
                          }
                          double cost;
                          print('pass');
                          return Container(
                            child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (BuildContext context, int i){
                                  print(i);
                                  cost = cart[i]['price']*int.parse(quantity[i]);
                                  totalCost+=cost;
                                  if(snapshot.connectionState!=ConnectionState.done){
                                    print('loading');
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
                                  }
                                  else if(cart.length>0){
                                    print('print');
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
                                                      child: Image.network(cart[i]['url'].toString(), fit: BoxFit.cover, height: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      currentPostID = cart[i].documentID;
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
                                                            Text(cart[i]['type'].toString(), style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
                                                            SizedBox(height: 10.0,),
                                                            Text('\$'+round.format(cost).toString(), style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),),
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
                                    print('none');
                                    return Center(
                                      child: Text('No Items'),
                                    );
                                  }
                                }
                            ),
                          );
                        }

                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price: ', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
                      Text('\$${round.format(totalCost)}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),

              ],
            )
          ),
          SizedBox(height: 12.0,),
          Icon(Icons.keyboard_arrow_up, size: 40.0, color: Colors.white,),
          Text('Purchase', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        ],
      ),
    );
  }
}
