import 'package:farming_app/screens/listings_page.dart';
import 'package:farming_app/screens/sales_page.dart';
import 'package:farming_app/widgets/open_listings.dart';
import 'package:farming_app/widgets/profile_bar.dart';
import 'package:farming_app/widgets/recent_purchases.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int pageIndex = 0;
  //List<Widget> pages = [SalesPage(), ListingsPage()];
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 150,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    image: DecorationImage(image: AssetImage('assets/images/donald.jpg'),
                    fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Vincent Do',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize: 30
                    ),
                  ),
                ),
                SizedBox(height: 0,),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                      child: new LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        width: 250.0,
                        lineHeight: 20.0,
                        percent: 0.9,
                        animation: true,
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.mood_bad),
                        ),
                        center: Text(
                          "Overall Rating Score",
                          style: new TextStyle(fontSize: 16.0),
                      ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.mood),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.amberAccent,
                  ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '16',
                            style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 20),
                          ),
                          Text('Sales')
                        ],
                      ),
                      SizedBox(width: 80,),
                      Column(
                        children: <Widget>[
                          Text(
                            '14',
                            style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 20),
                          ),
                          Text('purchases')
                        ],
                      ),
                      SizedBox(width: 80,),
                      Column(
                        children: <Widget>[
                          Text(
                            '214\$',
                            style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 20),
                          ),
                          Text('made')
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                          _pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 300), curve: Curves.linear);
                        });
                      },
                      child: Text(
                        'Listings',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: pageIndex == 0 ? FontWeight.bold
                              : FontWeight.w400,
                          // decoration: pageIndex == 0 ? TextDecoration.underline
                          //     : TextDecoration.none
                        ),
                      ),
                    ),
                    SizedBox(width: 50,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          pageIndex = 1;
                          _pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 300), curve: Curves.linear);
                          //Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                        });
                      },
                      child: Text(
                        'Recent Sales',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: pageIndex == 1 ? FontWeight.bold
                              : FontWeight.w400,
                          // decoration: pageIndex == 1 ? TextDecoration.underline
                          //     : TextDecoration.none
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    /*Expanded(
                      child: PageView(
                        //children: pages,
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),

                      ),
                    )*/
                  ],
                ),
              ],
            ),
          )
        ],
      ),



























      /*
      body: ListView(
        children: [
          ProfileBar(),
          SizedBox(height: 20,),
          //InfoBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Recent Sells & Purchases',
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
      ), */
    );
  }
}
