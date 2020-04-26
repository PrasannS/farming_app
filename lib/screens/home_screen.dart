import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/models/plant.dart';
import 'package:farming_app/models/user.dart';
import 'package:farming_app/widgets/famousCard.dart';
import 'package:farming_app/widgets/searchBar.dart';
import 'package:farming_app/widgets/welcomeBar.dart';
import 'package:farming_app/widgets/yourPlants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool plantloaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    runSetup();
  }

  List<Plant> userplants = [];

  FirebaseUser user;

  List<User> users = [];
  bool usersloaded = false;


  Future runSetup() async{
    getAllPosts();
    getAllFarmers();
  }




  Future getAllPosts() async{
    await FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        user = value;
        print("TASK COMPLETE");
      });
    });
    Firestore.instance.collection('posts').getDocuments().then((snapshot){
      for (DocumentSnapshot ds in snapshot.documents){
        setState(() {
          if(ds.data['uid']==user.uid)
            userplants.add(Plant.fromMap(ds.data));
        });
      }
      setState(() {
        plantloaded = true;
      });
    });

  }

  Future getAllFarmers() async{
    Firestore.instance.collection('users').getDocuments().then((snapshot){
      for (DocumentSnapshot ds in snapshot.documents){
        setState(() {
          print(ds.data);
          User u = User.fromMap(ds.data);
          users.add(u);

        });
      }
      setState(() {
        usersloaded = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            WelcomeBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Farm with Friends', maxLines: 1,
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
            plantloaded?YourPlants(plants: userplants,):Center(child: CircularProgressIndicator(),),

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
            usersloaded?Flexible(
              child: Container(
                width: 200*users.length*1.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (_, index) {
                      print("HELLOOOOOO");
                      print(users.length);
                      return  FamousCard(
                        name: users[index].name,
                        picture: users[index].image,
                        onSale: true,
                      );
                    },
                  ),
              ),
            ):
            Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }
}
