import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favs/blocs/favorite_bloc.dart';
import 'package:youtube_favs/blocs/video_bloc.dart';
import 'package:youtube_favs/delegates/data_search.dart';
import 'package:youtube_favs/models/video_model.dart';
import 'package:youtube_favs/ui/favorite_page.dart';
import 'package:youtube_favs/widgets/video_tile.dart';

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
              child: StreamBuilder<Map<String, VideoModel>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Text("${snapshot.data.length}");
                  }else {
                    return Container();
                  }
                },
              ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritePage())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
          stream: BlocProvider.getBloc<VideoBloc>().outVideos,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if(index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  }else if(index > 1){
                    BlocProvider.getBloc<VideoBloc>().inSearch.add(null);
                    return Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  }else {
                    return Container();
                  }
                },
              );
            }else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
