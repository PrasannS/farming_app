import 'package:farming_app/widgets/purchase_card.dart';
import 'package:flutter/material.dart';

class RecentPurchases extends StatefulWidget {
  @override
  _RecentPurchasesState createState() => _RecentPurchasesState();
}

class _RecentPurchasesState extends State<RecentPurchases> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: PurchaseCard(
              name: 'The Good Stuff',
              price: 500.00,
              picture: '',
              rating: 0.9,
            ),
          );
        },
      ),
    );
  }
}
