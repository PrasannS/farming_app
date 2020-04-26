import 'package:farming_app/models/plant.dart';
import 'package:farming_app/widgets/plantCard.dart';
import 'package:flutter/material.dart';


class YourPlants extends StatelessWidget {

  final List<Plant> plants;


  const YourPlants({Key key,this.plants}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (_, index) {
          return PlantCard(
            name: plants[index].name,
            picture: plants[index].image,
            progress: plants[index].progress/70.0,
          );
        },
      ),
    );
  }
}
