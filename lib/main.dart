import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favs/api.dart';
import 'package:youtube_favs/blocs/favorite_bloc.dart';
import 'package:youtube_favs/blocs/video_bloc.dart';
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
    return BlocProvider(
      blocs: [
        Bloc((i) => VideoBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'FlutterTube',
        home: Home(),
      ),
    );
  }
}