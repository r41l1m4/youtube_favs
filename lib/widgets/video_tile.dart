import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favs/blocs/favorite_bloc.dart';
import 'package:youtube_favs/models/video_model.dart';

class VideoTile extends StatelessWidget {

  final VideoModel video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          video.channel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, VideoModel>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(video.id) ?
                              Icons.star : Icons.star_border),
                      color: Colors.yellowAccent,
                      tooltip: "Favoritar",
                      iconSize: 30.0,
                      onPressed: () {
                        BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
                      },
                    );
                  }else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
