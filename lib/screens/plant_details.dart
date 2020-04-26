import 'package:flutter/material.dart';

class PlantDetails extends StatefulWidget {
  @override
  _PlantDetailsState createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: SafeArea(
        child: (
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/weed.jpg",
                  height: 350,
                  fit: BoxFit.cover,),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.07),
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        })
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.not_interested, size: 30,
                                color: Colors.red,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Align(alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.09),
                          Colors.white.withOpacity(0.01),
                          Colors.white.withOpacity(0.00001),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(),
                    ),
                  ),),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('The Good Stuff',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Cannabacaeae',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8), fontSize: 26, fontWeight: FontWeight.w100
                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
        ),
      ),
    );
  }
}
