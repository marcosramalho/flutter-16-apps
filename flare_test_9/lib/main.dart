import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,

    );
  }  
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          child: FlareActor("assets/AnimGears1.flr", animation: "spin",),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home())
      );
    });
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Flutter + Flare",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 100,
            width: 100,
            child: FlareActor("assets/AnimHeart1.flr", animation: "pulse",),
          ),
        ],
      ),
    );
  }
}