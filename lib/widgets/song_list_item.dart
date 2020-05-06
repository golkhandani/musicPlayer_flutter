import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:news_app/models/Song.dart';
import 'package:news_app/widgets/circle_button.dart';

class SongListItem extends StatelessWidget {
  const SongListItem({
    Key key,
    @required this.song,
    this.isOnPlay = false,
    @required this.onPlayPress,
  }) : super(key: key);

  final SongInfo song;
  final bool isOnPlay;
  final Function onPlayPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Center(
            child: Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.only(right: 16, top: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  song.displayName,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(8),
            child: RoundIconButton(
              size: 40,
              onPressed: () {
                onPlayPress(song.id);
              },
              icon: isOnPlay ? Icons.pause : Icons.play_arrow,
            ),
          )
        ],
      ),
    );
  }
}
