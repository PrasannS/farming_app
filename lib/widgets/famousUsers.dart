import 'package:flutter/material.dart';

import 'famousCard.dart';

class FamousUsers extends StatefulWidget {
  @override
  _FamousUsersState createState() => _FamousUsersState();
}

class _FamousUsersState extends State<FamousUsers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index){
          return FamousCard(
            name: 'Donald Trump',
            price: 2000.00,
            picture: '',
            onSale: true,
          );
        },
      ),
    );
  }
}
