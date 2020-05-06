import 'package:flutter/material.dart';
import 'package:news_app/bloc/my_music_player_bloc.dart';
import 'package:news_app/pages/loading_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyMusicPlayerBLoc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Loading(),
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
