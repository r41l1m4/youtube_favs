import 'package:flutter/material.dart';
import 'package:youtube_favs/delegates/data_search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
            height: 25,
            child: Image.asset("images/yt_logo_rgb_dark.png")
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
              child: Text("0")
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              print(result);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
