import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/models/plant.dart';
import 'package:farming_app/models/user.dart';
import 'package:farming_app/screens/add_plant_screen.dart';
import 'package:farming_app/widgets/famousCard.dart';
import 'package:farming_app/widgets/searchBar.dart';
import 'package:farming_app/widgets/welcomeBar.dart';
import 'package:farming_app/widgets/yourPlants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    runSetup();
  }

  List<DocumentSnapshot> userplants;

  FirebaseUser user;

  List<DocumentSnapshot> users = [];
  bool usersloaded = false;

  Future runSetup() async {
    getAllPosts();
    getAllFarmers();
  }

  Future getAllPosts() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        user = value;
        print("TASK COMPLETE");
      });
    });
    Firestore.instance.collection('posts').getDocuments().then((snapshot) {
      List<DocumentSnapshot> setDocs = new List<DocumentSnapshot>();
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['uid'] == user.uid) {
          setDocs.add(snapshot.documents[i]);
        }
      }
      setState(() {
        userplants = new List();
        userplants = setDocs;
      });
    });
  }

  Future getAllFarmers() async {
    Firestore.instance.collection('users').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
          users.add(ds);
      }
      users.sort((userA, userB) {
        int userAPlanted = 0;
        int userBPlanted = 0;
        if (userA.data['posts'] != null) {
          userAPlanted = userA.data['posts'].length;
        }
        if (userB.data['posts'] != null) {
          userBPlanted = userB.data['posts'].length;
        }
        return (userAPlanted - userBPlanted);
      });
      setState(() {
        usersloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPlantScreen())),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            WelcomeBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Farm with Friends',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SearchBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Text(
                      'Your Plants',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              ],
            ),
            userplants == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : YourPlants(
              plants: userplants,
            ),
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
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            usersloaded
                ? Container(
                    height: 110 * users.length * 1.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: users.length,
                      itemBuilder: (_, index) {
                        print("HELLOOOOOO");
                        print(users.length);
                        int numPlanted = 0;
                        if (users[index].data['posts'] != null) {
                          numPlanted = users[index].data['posts'].length;
                        }
                        return FamousCard(
                          name: users[index].data['name'],
                          cropsPlanted: numPlanted,
                          onSale: true,
                        );
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
