import 'package:chat_7/chat_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  
  runApp(MyApp());
}

final ThemeData KIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light
);

final ThemeData KDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400]
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,      
      theme: Theme.of(context).platform == TargetPlatform.iOS ? KIOSTheme : KDefaultTheme,
      home: ChatScreen(),
    );
  }
}
