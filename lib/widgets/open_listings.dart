import 'package:flutter/material.dart';

import 'listing_card.dart';

class OpenListings extends StatefulWidget {
  @override
  _OpenListingsState createState() => _OpenListingsState();
}

class _OpenListingsState extends State<OpenListings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListingCard(
              name: 'The Goods',
              price: 2000.00,
              quantity: 4,
            ),
          );
        }
      )
      );
  }
}
