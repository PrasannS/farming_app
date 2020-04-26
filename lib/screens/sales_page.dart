import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
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
