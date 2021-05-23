import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

Widget blacksmithOverlayBuilder(BuildContext context, MyGame myGame) {
  return const BlacksmithOverlay();
}

class BlacksmithOverlay extends StatefulWidget {

  const BlacksmithOverlay({Key key}): super(key: key);

  @override
  _BlacksmithOverlayState createState() => _BlacksmithOverlayState();
}

class _BlacksmithOverlayState extends State<BlacksmithOverlay> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        color: const Color(0xFFFF0000),
        child: const Center(
          child: Text('Blacksmith Menu'),
        ),
      ),
    );
  }
}