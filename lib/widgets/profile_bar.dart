import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
          Positioned(
            top: 10,
            bottom: 0,
            right: 220,
            left: 40 ,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('https://stayhipp.com/wp-content/uploads/2019/01/IT-AINT-MUCH.jpg'),
            ),
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: (
                  Container(
                    child: Icon(Icons.arrow_back_ios,)
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Profile', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: Colors.green
                ),
                ),
              ),
            ],
          ),
          SizedBox(height: 150,),
          Positioned(
            top: 60,
            bottom: 0,
            right: 50,
            left: 225,
            child: Text(
              'Vincent', style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.green
            ),
            ),
          ),
          Positioned(
            top: 95,
            bottom: 0,
            right: 50,
            left: 225,
            child: Text(
              'Do', style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.green
            ),
            ),
          )
        ],
      );
  }
}
