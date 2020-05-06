import 'dart:async';
import 'dart:io';
import 'package:news_app/widgets/slider_box.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:news_app/bloc/my_music_player_bloc.dart';
import 'package:news_app/widgets/circle_button.dart';

class PlayerPage extends StatefulWidget {
  PlayerPage({
    Key key,
    this.seek,
  }) : super(key: key);
  final int seek;

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    MyMusicPlayerBLoc playerBLoc = Provider.of<MyMusicPlayerBLoc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("MAIN P"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleSpacing: 1,
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.transparent,
              child: Hero(
                tag: "cover_image",
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange[700],
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                          spreadRadius:
                              1.0, // has the effect of extending the shadow
                          offset: Offset(
                            1.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                      image: playerBLoc.selectedSong == null
                          ? null
                          : playerBLoc.selectedSong.albumArtwork != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(playerBLoc.selectedSong.albumArtwork),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 48, left: 16, right: 16),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              playerBLoc.selectedSong.title,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              playerBLoc.selectedSong.artist,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              playerBLoc.selectedSong.album,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Center(
                                child: SliderBox(
                                  onChanged: (double newVal) {
                                    playerBLoc.seek(newVal.round());
                                    // setState(() {
                                    //   _start = newVal.round();
                                    // });
                                  },
                                  seek: playerBLoc.selectedSongSeek,
                                  maxSeek: int.parse(
                                      playerBLoc.selectedSong.duration),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RoundIconButton(
                                      size: 60,
                                      onPressed: () {
                                        playerBLoc.goBack();
                                      },
                                      icon: Icons.skip_previous,
                                    ),
                                    RoundIconButton(
                                      size: 100,
                                      onPressed: () {
                                        playerBLoc
                                            .playPause(playerBLoc.selectedSong);
                                      },
                                      icon: playerBLoc.playerStatus !=
                                              PlayerStatus.play
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                    ),
                                    RoundIconButton(
                                      size: 60,
                                      onPressed: () {
                                        playerBLoc.goNext();
                                      },
                                      icon: Icons.skip_next,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
