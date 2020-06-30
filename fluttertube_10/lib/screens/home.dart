import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube_10/blocs/favorite_bloc.dart';
import 'package:fluttertube_10/blocs/videos_bloc.dart';
import 'package:fluttertube_10/delegates/data_search.dart';
import 'package:fluttertube_10/models/video.dart';
import 'package:fluttertube_10/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              initialData: {},
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text("${snapshot.data.length}");                  
                
                return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star), 
            onPressed: () {

            }
          ),
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());

              if (result != null) 
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
            }
          )
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length)
                  return VideoTile(snapshot.data[index]);
                
                if (index > 1) {
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                }

                return Container();
                
              },
              itemCount: snapshot.data.length + 1,
            );
          }

          return Container();
        }
      )
    );
  }
}