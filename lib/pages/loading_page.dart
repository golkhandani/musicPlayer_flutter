import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/bloc/my_music_player_bloc.dart';
import 'package:news_app/pages/song_list_page.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  Future<void> getArchiveAndNavigate(context, playerBLoc) async {
    await playerBLoc.getAllFiles();
    //await playerBLoc.stop();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return MyHomePage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyMusicPlayerBLoc playerBLoc =
        Provider.of<MyMusicPlayerBLoc>(context);
    getArchiveAndNavigate(context, playerBLoc);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: SpinKitRipple(
            color: Colors.orange,
            size: 220,
            borderWidth: 20,
            duration: Duration(seconds: 2),
          ),
        ),
      ),
    );
  }
}
