import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PurchaseCard extends StatelessWidget {

  final String name;
  final String picture;
  final double price;
  final double rating;

  const PurchaseCard({Key key, this.name, this.picture, this.price, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},

        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(62, 168, 174, 201),
                offset: Offset(0,9),
                blurRadius: 14,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset("assets/images/bananas.jpg",
                  height: 220,
                  width: 250,
                  fit: BoxFit.cover,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: LinearPercentIndicator(
                      width: 185,
                      leading: Icon(Icons.mood_bad, color: Colors.white,),
                      animation: true,
                      lineHeight: 20,
                      animationDuration: 2000,
                      percent: rating,
                      trailing: Icon(Icons.mood, color: Colors.white,),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.amberAccent.withOpacity(0.9),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 2),
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$name \n',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        TextSpan(text: '\$${price.toString()}\n',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )),
                          TextSpan(text: 'SOLD',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold
                              )),
                        ]
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
