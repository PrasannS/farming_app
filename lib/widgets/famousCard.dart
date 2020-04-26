import 'package:flutter/material.dart';

class FamousCard extends StatelessWidget {
  final String name;
  final String picture;
  final double price;
  final bool onSale;

  const FamousCard({Key key, this.name, this.picture, this.price, this.onSale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: picture==null?Image.asset(
                "assets/images/donald.jpg",
                height: 90,
                width: 70,
                fit: BoxFit.cover,
              ):
              Image.network(
                picture,
                height: 90,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: '$name \n', style: TextStyle(fontSize: 25,
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.bold),),
              TextSpan(text: '\n', style: TextStyle(
                fontSize: 5
              )),
              TextSpan(
                text: '\$${price.toString()} made\t',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: Colors.green),
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.red),
              ),
            ], style: TextStyle(
                color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
