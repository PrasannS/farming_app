import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    3.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: new BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('assets/img/mcdonalds.png',
                fit: BoxFit.cover,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    3.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: new BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('assets/img/tomatoes.jpeg',
                fit: BoxFit.cover,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    3.0, // horizontal, move right 10
                    3.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: new BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('assets/img/seeds.jpg',
                fit: BoxFit.cover,),
            ),
          ),
        ),

      ],
    );
  }
}
