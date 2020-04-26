import 'package:flutter/material.dart';

class ListingsPage extends StatefulWidget {
  @override
  _ListingsPageState createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        Card(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/donald.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),
        ),
        Card(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/donald.jpg'),
                  fit: BoxFit.cover,
                )
            ),
          ),
        ),
        Card(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/donald.jpg'),
                  fit: BoxFit.cover,
                )
            ),
          ),
        ),
      ],
    );
  }
}