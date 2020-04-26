import 'package:farming_app/screens/post_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PlantInfoScreen extends StatefulWidget {
  @override
  _PlantInfoScreenState createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> {

  _openPostPage(BuildContext context){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => PostPage()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.red,
                    child: Image.asset("assets/img/tomatoes.jpeg",
                      fit: BoxFit.cover,
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
              //title
              Text(
                'The Good Stuff',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              //description
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0
                ),
                child: Text(
                  'Cannabacaeae',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),




              SizedBox(height: 10.0,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('This is where a description of the plant would go',
                  ),
                ),

              SizedBox(height: 20.0,),
              Container(
                child: CircularPercentIndicator(
                  radius: 200,
                  lineWidth: 20,
                  animation: true,
                  percent: 0.8,
                  center: Icon(Icons.check_circle,
                    color: Colors.green,
                    size: 100,),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                ),
              ),

              SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xffFFD819),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                      child: InkWell(
                        onTap:() => _openPostPage(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200.0,
                              height: 50.0,
                              child: Center(child: Text('Harvest and Sell', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),))),
                        ),
                      )
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}