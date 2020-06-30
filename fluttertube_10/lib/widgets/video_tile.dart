import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube_10/api.dart';
import 'package:fluttertube_10/blocs/favorite_bloc.dart';
import 'package:fluttertube_10/models/video.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
          apiKey: API_KEY, 
          videoId: video.id
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0/9.0,
              child: Image.network(video.thumb, fit: BoxFit.cover),  
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
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
                            fontSize: 14
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border), 
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
                        }
                      );
                    }

                    return CircularProgressIndicator();
                  },
                )
              
              ],
            )
          ],
        ),
      ),
    );
  }
}