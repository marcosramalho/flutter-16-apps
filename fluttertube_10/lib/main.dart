import 'package:flutter/material.dart';
import 'package:fluttertube_10/api.dart';
import 'package:fluttertube_10/screens/home.dart';

void main() async {
  Api api = Api();

  await api.search("eletro");
  runApp(MyApp());
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}