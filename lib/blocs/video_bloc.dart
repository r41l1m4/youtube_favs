
import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favs/api.dart';
import 'package:youtube_favs/models/video_model.dart';

class VideoBloc extends BlocBase {
  Api api;

  List<VideoModel> videos;

  final _videosController = StreamController<List<VideoModel>>();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
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
    if(search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    }else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);

  }
}