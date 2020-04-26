import 'package:farming_app/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RestaurantMarket extends StatefulWidget {
  @override
  _RestaurantMarketState createState() => _RestaurantMarketState();
}

class _RestaurantMarketState extends State<RestaurantMarket> {
  @override
  Widget build(BuildContext context) {
    List names = ['mcdonalds', 'china cottage', 'weed store'];

    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantScreen())),
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
                              child: Image.asset('assets/img/mcdonalds.png', fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(names[index], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
                                SizedBox(height: 10.0,),
                                Text('Needs tomatoes, potatoes, and weed', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),),
                                SizedBox(height: 15.0,),
                                Text('5 crop minimum', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),
                                SizedBox(height: 15.0,),
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
    );
  }
}
