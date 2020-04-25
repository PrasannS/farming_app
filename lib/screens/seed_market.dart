import 'package:flutter/material.dart';

class SeedMarket extends StatefulWidget {
  @override
  _SeedMarketState createState() => _SeedMarketState();
}

class _SeedMarketState extends State<SeedMarket> {
  List names = ['tomatoes', 'potatoes', 'weed'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index){
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
          );
        }
    );
  }
}
