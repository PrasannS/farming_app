import 'package:farming_app/widgets/famousCard.dart';
import 'package:farming_app/widgets/famousUsers.dart';
import 'package:farming_app/widgets/searchBar.dart';
import 'package:farming_app/widgets/welcomeBar.dart';
import 'package:farming_app/widgets/yourPlants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            WelcomeBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Farm with Friends',
              style: TextStyle(
                fontSize: 45, color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),),
            ),
            SearchBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Text('Your Plants',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Icon(Icons.navigate_next,
                    color: Colors.blueGrey,),
                  ),
                )
              ],
            ),
            YourPlants(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Most popular farmers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Icon(Icons.navigate_next,
                      color: Colors.blueGrey,),
                  ),
                ),
              ],
            ),
            FamousCard(
              name: 'Donald Trump',
              price: 2000.00,
              picture: '',
              onSale: true,
            ),
            FamousCard(
              name: 'Your Mom',
              price: 300.00,
              picture: '',
            ),
            FamousCard(
              name: 'My Dad',
              price: 100.00,
              picture: '',
            ),
            FamousCard(
              name: 'Me',
              price: 1.00,
              picture: '',
            ),
          ],
        ),
      ),
    );
  }
}
