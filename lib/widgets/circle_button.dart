import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.size = 56,
  }) : super(key: key);
  final double size;
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 8,
      constraints: BoxConstraints.tightFor(width: size, height: size),
      shape: CircleBorder(),
      fillColor: Colors.orange,
      child: Icon(
        icon,
        color: Colors.black,
        size: 2 * size / 3,
      ),
    );
  }
}
