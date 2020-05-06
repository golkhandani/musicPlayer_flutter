
import 'package:flutter/material.dart';

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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.baseline,
        //   textBaseline: TextBaseline.alphabetic,
        //   children: [
        //     Text(
        //       "$seek",
        //     ),
        //     SizedBox(
        //       width: 8,
        //     ),
        //     Text("sec"),
        //   ],
        // ),
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
