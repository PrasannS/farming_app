import 'package:farming_app/screens/plant_details.dart';
import 'package:farming_app/screens/plantinfo_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PlantCard extends StatelessWidget {

  final String name;
  final String picture;
  final double progress;

  const PlantCard({Key key, this.name, this.picture, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> PlantInfoScreen()));
        },
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
                Image.network(
                  picture,
                  height: 220,
                  width: 200,
                  fit: BoxFit.cover,
                ),
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
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: LinearPercentIndicator(
                      width: 185,
                      animation: true,
                      lineHeight: 20,
                      animationDuration: 2000,
                      percent: progress,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.lightGreenAccent.withOpacity(0.9),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$name \n',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ), /*
                        TextSpan(text: '\$${price.toString()} made\n',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )) */
                        ]
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
