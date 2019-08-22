
import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favs/api.dart';
import 'package:youtube_favs/models/video_model.dart';

class VideoBloc extends BlocBase {
  Api api;

  List<VideoModel> videos;

  final _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  void _search(String search) async {
    videos = await api.search(search);
    print(videos);
  }
}