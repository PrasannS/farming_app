import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

class VideosPage extends StatefulWidget {

  final String item;

  const VideosPage({Key key, this.item}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  
  List<YT_API> ytRes = [];

  static String key = "AIzaSyDuhrq58n8OWBQGN2AoQBEL-51DCf6pchM";
  YoutubeAPI ytApi = new YoutubeAPI(key);
  bool ytloaded = false;


  callYTAPI(String item) async {
    print('UI callled');
    ytRes = await ytApi.search("How to plant "+item);
    setState(() {
      ytRes = ytRes;
      ytloaded = true;
      print('UI Updated');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callYTAPI(widget.item);
  }

  
  @override
  Widget build(BuildContext context) {
    print(ytRes);
    return ytloaded? new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        height: 400.0 * ytRes.length,
        child: new ListView.builder(
            itemCount: ytRes.length - 1,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return new Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),

                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "0" + (++index).toString(),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(.5),
                                        fontSize: 32,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      width: 300,
                                      child: Text(
                                        ytRes[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            height: 1.5,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new NetworkImage(
                                ytRes[index].thumbnail['high']['url']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ))
                  ],
                ),
              );
            }),
      ),
    ):
    Center(child: CircularProgressIndicator(),);
  }
}
