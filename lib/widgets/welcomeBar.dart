import 'package:flutter/material.dart';

class WelcomeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
        /* Positioned(
          top: 15,
          right: 20,
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.menu,
              size: 30,),
          ),
        ),
         Positioned(
          top: 15,
          right: 48,
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.person,
            size: 40,),
          ),
        ),
        Positioned(
          top: 15,
          right: 96,
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.monetization_on,
            size: 40,),
          ),
        ), */
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Welcome to',
            style: TextStyle(
              fontSize: 40, color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w100,
            ),),
        )
      ],
    );
  }
}
