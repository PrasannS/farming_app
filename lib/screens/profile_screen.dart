import 'package:farming_app/widgets/open_listings.dart';
import 'package:farming_app/widgets/profile_bar.dart';
import 'package:farming_app/widgets/recent_purchases.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ProfileBar(),
            SizedBox(height: 20,),
            //InfoBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Recent Sales & Purchases',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            RecentPurchases(),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Opening Listings in Store',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            OpenListings(),
            SizedBox(height: 10,),
            Padding(
              padding:
              const EdgeInsets.all(9),
              child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "View Purchase/Sell History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
