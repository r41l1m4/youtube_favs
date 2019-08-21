import 'package:flutter/material.dart';
import 'package:youtube_favs/api.dart';
import 'package:youtube_favs/ui/home_page.dart';

void main() {
  Api api = Api();
  api.search("vish");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterTube',
      home: Home(),
    );
  }
}