import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_favs/api.dart';
import 'package:youtube_favs/blocs/favorite_bloc.dart';
import 'package:youtube_favs/models/video_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children: snapshot.data.values.map(
                      (v) {
                    return InkWell(
                      onTap: () {
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: API_KEY,
                            videoId: v.id
                        );
                      },
                      onLongPress: () {
                        BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(v);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 50,
                            child: Image.network(v.thumb),
                          ),
                          Expanded(
                            child: Text(
                              v.title,
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ).toList(),
            );
          }else {
            return Container(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
