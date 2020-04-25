import 'package:farming_app/widgets/plantCard.dart';
import 'package:flutter/material.dart';

class YourPlants extends StatefulWidget {
  @override
  _YourPlantsState createState() => _YourPlantsState();
}

class _YourPlantsState extends State<YourPlants> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return PlantCard(
            name: 'The Good Stuff',
            price: 500.00,
            picture: '',
            progress: 0.5,
          );
        },
      ),
    );
  }
}
