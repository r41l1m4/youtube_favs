import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favs/models/video_model.dart';

class FavoriteBloc extends BlocBase {

  Map<String, VideoModel> _favorites = {};

  final _favController = StreamController<Map<String, VideoModel>>();
  Stream<Map<String, VideoModel>> get outFav => _favController.stream;

  void toggleFavorite(VideoModel video) {
    if(_favorites.containsKey(video.id)) _favorites.remove(video.id);
    else _favorites[video.id] = video;

    _favController.sink.add(_favorites);
  }

  @override
  void dispose() {
    _favController.close();
  }
}