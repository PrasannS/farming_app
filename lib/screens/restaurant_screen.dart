import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0
                          )
                      ),
                      child: Image.asset(
                        "assets/img/mcdonaldsshop.jpg", fit: BoxFit.cover,
                      )
                  ),
                ),
                Positioned(
                  top: 15.0,
                  left: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios, size: 30.0, color: Colors.white,
                    ),
                    onPressed: () =>
                        Navigator.pop(context
                        ),
                  ),
                ),
                Positioned(
                  top: 15.0,
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.add, size: 35.0, color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('McDonalds',
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10.0,
                  ),
                  Text('7104 S Fry Rd, Katy, TX 77494',
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 10.0,
                  ),
                  SizedBox(height: 10.0,
                  ),
                  Text(
                    'This is a description of the store. this mcdonalds needs some super nice lookin juicy red tomatoes and potatoes.',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 20.0,
                  ),
                  Container(
                    height: 200.0,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Text('Tomatoes', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
                              Spacer(),
                              IconButton(icon: Icon(Icons.add_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                              Text('10', style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20.0
                              ),
                              ),
                              IconButton(icon: Icon(Icons.remove_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Text('Potatoes', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
                              Spacer(),
                              IconButton(icon: Icon(Icons.add_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                              Text('10', style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20.0
                              ),
                              ),
                              IconButton(icon: Icon(Icons.remove_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Text('Weeds', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
                              Spacer(),
                              IconButton(icon: Icon(Icons.add_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                              Text('10', style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20.0
                              ),
                              ),
                              IconButton(icon: Icon(Icons.remove_circle
                              ), iconSize: 30.0, onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        //add to cart button
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0
                            ),
                            color: Color(0xffFFD819
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius
                                  .circular(50.0
                              )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    SizedBox(width: 10.0,
                                    ),
                                    Text('Sell and Deliver', style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600
                                    ),
                                    ),
                                    SizedBox(width: 30.0,
                                    ),
                                    IconButton(icon: Icon(Icons.check
                                    ), iconSize: 30.0,
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
                          borderRadius: BorderRadius.circular(10.0
                          ),
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.8
                          )
                          ),
                          //color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(Icons.favorite_border, size: 30.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}