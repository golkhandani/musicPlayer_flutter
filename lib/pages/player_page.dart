import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/my_music_player_bloc.dart';
import 'package:news_app/models/Song.dart';
import 'package:news_app/widgets/circle_button.dart';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

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
  Timer _timer;
  void startTimer(MyMusicPlayerBLoc playerBLoc) async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      playerBLoc.getSeek();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyMusicPlayerBLoc playerBLoc = Provider.of<MyMusicPlayerBLoc>(context);
    // playerBLoc.getSeek();
    // this._start = widget.seek != null ? widget.seek : 0;
    startTimer(playerBLoc);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("MAIN P"),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleSpacing: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // hero image
                Hero(
                  tag: "cover_image",
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
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
                                      File(
                                          playerBLoc.selectedSong.albumArtwork),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          playerBLoc.selectedSong.title,
                          style: TextStyle(fontSize: 30, color: Colors.white),
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
                  Expanded(
                    child: Center(
                      child: SliderBox(
                        onChanged: (double newVal) {
                          playerBLoc.seek(newVal.round());
                          // setState(() {
                          //   _start = newVal.round();
                          // });
                        },
                        seek: playerBLoc.selectedSongSeek,
                        maxSeek: int.parse(playerBLoc.selectedSong.duration),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundIconButton(
                            size: 60,
                            onPressed: () {},
                            icon: Icons.skip_previous,
                          ),
                          RoundIconButton(
                            size: 100,
                            onPressed: () {
                              playerBLoc.playPause(playerBLoc.selectedSong);
                            },
                            icon: playerBLoc.playerStatus != PlayerStatus.play
                                ? Icons.play_arrow
                                : Icons.pause,
                          ),
                          RoundIconButton(
                            size: 60,
                            onPressed: () {},
                            icon: Icons.skip_next,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliderBox extends StatelessWidget {
  const SliderBox({
    Key key,
    @required this.seek,
    @required this.onChanged,
    @required this.maxSeek,
  }) : super(key: key);

  final int seek;
  final int maxSeek;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "$seek",
            ),
            SizedBox(
              width: 8,
            ),
            Text("sec"),
          ],
        ),
        SliderTheme(
          // can be add to theme data
          data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 15,
              ),
              thumbColor: Colors.orange,
              activeTrackColor: Colors.white,
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 30,
              ),
              overlayColor: Colors.orange[200]),
          child: Slider(
            inactiveColor: Colors.grey,
            value: seek.toDouble(),
            min: 0,
            max: maxSeek.toDouble(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
