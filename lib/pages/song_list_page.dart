import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:news_app/bloc/my_music_player_bloc.dart';
import 'package:news_app/models/Song.dart';
import 'package:news_app/pages/player_page.dart';
import 'package:news_app/widgets/circle_button.dart';
import 'package:news_app/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final MyMusicPlayerBLoc playerBLoc =
        Provider.of<MyMusicPlayerBLoc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("PLAYER".toUpperCase()),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 1,
      ),
      body: Column(
        children: <Widget>[
          // Banner Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // forward
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: RoundIconButton(
                        onPressed: () {},
                        icon: Icons.skip_previous,
                      ),
                    ),
                  ),
                  // hero image
                  Expanded(
                    flex: 3,
                    child: Hero(
                      tag: "cover_image",
                      child: GestureDetector(
                        onTap: () async {
                          if (playerBLoc.selectedSong != null) {
                            int seekTime = await playerBLoc.getSeek();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return PlayerPage(
                                    seek: seekTime,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: Container(
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
                                          File(playerBLoc
                                              .selectedSong.albumArtwork),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // forwar
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: RoundIconButton(
                        onPressed: () {},
                        icon: Icons.skip_next,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 16,
          ),
          // List Section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: playerBLoc.songs.length,
                itemBuilder: (context, index) => SongListItem(
                  song: playerBLoc.songs[index],
                  isOnPlay:
                      playerBLoc.songs[index] == playerBLoc.selectedSong &&
                              playerBLoc.playerStatus == PlayerStatus.play
                          ? true
                          : false,
                  onPlayPress: (String itemId) {
                    SongInfo userSelect = playerBLoc.songs
                        .firstWhere((element) => element.id == itemId);
                    print(userSelect);
                    playerBLoc.playPause(userSelect);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
