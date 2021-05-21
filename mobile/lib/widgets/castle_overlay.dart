
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

Widget castleOverlayBuilder(BuildContext context, MyGame myGame) {
  return const CastleOverlay();
}

class CastleOverlay extends StatefulWidget {

  const CastleOverlay({Key key}): super(key: key);

  @override
  _CastleOverlayState createState() => _CastleOverlayState();
}

class _CastleOverlayState extends State<CastleOverlay> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        color: const Color(0xFFFF0000),
        child: const Center(
          child: Text('Castle Menu'),
        ),
      ),
    );
  }
}