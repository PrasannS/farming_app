import 'package:farming_app/screens/produce_screen.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List names = ['tomatoes', 'potatoes', 'weed'];
  @override
  Widget build(BuildContext context) {
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
                  child: ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProduceScreen())),
                          child: Padding(
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
                                          height: 160.0,
                                          width: 160.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(30.0),
                                            child: Image.asset('assets/img/seeds.jpg', fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.0,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Sunflower Seeds', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
                                              SizedBox(height: 10.0,),
                                              Text('Sunflower seeds that will grow into sunflowers', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),),
                                              SizedBox(height: 15.0,),
                                              Text('\$20/gram', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
                                              SizedBox(height: 15.0,),
                                              Text('10 - 20 days to grow', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price: ', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
                      Text('\$180.21', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400),),
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
