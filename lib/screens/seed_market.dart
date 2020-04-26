import 'package:farming_app/api_client/api_client.dart';
import 'package:farming_app/models/shop_result.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SeedMarket extends StatefulWidget {
  @override
  _SeedMarketState createState() => _SeedMarketState();
}

class _SeedMarketState extends State<SeedMarket> {
  List names = ['tomatoes', 'potatoes', 'weed'];

  List<ShopResult> shops = [];
  bool shoploaded = false;



  Widget getSearchBar(){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.all((Radius.circular(5.0)))
        ),
        child: TextField(
          controller: myController,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey[300],
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.white,),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: "E.g: fresh apples",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueGrey[300],
            ),
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey[300],
            ),
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  Future performSearch() async{
    setState(() {
      shoploaded = false;
    });
    fetchShopResult(myController.text).then((value){
      setState(() {
        shops = value;
        shoploaded = true;
      });
    });
  }

  _launchURL(String url) async {
    //const url = 'https://flutter.dev';
    url = url.replaceAll(" ", "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
        Container(
          width: 200,
          height: 100,
          child: Row(
            children: [
              Expanded(child: getSearchBar()),
              FlatButton(
                child: Text("SEARCH"),
                onPressed:(){
                  performSearch();
                },
              )
            ],
          ),
        ),
        Container(
          height: shops.length*210.0,
          child: shoploaded?ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: shops.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap:(){
                  _launchURL(shops[index].url);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 7.0, // has the effect of softening the shadow
                          spreadRadius: 1.0, // has the effect of extending the shadow
                          offset: Offset(
                            3.0, // horizontal, move right 10
                            3.0, // vertical, move down 10
                          ),
                        )
                      ],
                      borderRadius: new BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                          child: Row(
                            children: [
                              Container(
                                height: 160.0,
                                width: 160.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.network(shops[index].image, fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(shops[index].item, overflow: TextOverflow.fade,style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),)),

                                    SizedBox(height: 10.0,),
                                    Container(
                                        height: 50,child: Text('Seeds that will grow into produce', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),)),
                                    SizedBox(height: 15.0,),
                                    Container(
                                        height:25,child: Text(shops[index].price, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),)),
                                    SizedBox(height: 15.0,),
                                    Container(
                                        height:25,child: Text(shops[index].seller, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              );
            }
      ):Center(child: CircularProgressIndicator(),),
        ),
    ]);
  }
}