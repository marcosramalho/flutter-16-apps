import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube_10/api.dart';
import 'package:fluttertube_10/blocs/favorite_bloc.dart';
import 'package:fluttertube_10/blocs/videos_bloc.dart';
import 'package:fluttertube_10/screens/home.dart';

void main() async {
  //Api api = Api();

  //await api.search("eletro");
  runApp(MyApp());
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(      
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Home(),
      ),
    );
  }
}