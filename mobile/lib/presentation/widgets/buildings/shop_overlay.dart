
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

Widget shopOverlayBuilder(BuildContext context, MyGame myGame) {
  return const ShopOverlay();
}

class ShopOverlay extends StatefulWidget {

  const ShopOverlay({Key? key}): super(key: key);

  @override
  _ShopOverlayState createState() => _ShopOverlayState();
}

class _ShopOverlayState extends State<ShopOverlay> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        color: const Color(0xFFFF0000),
        child: const Center(
          child: Text('Shop Menu'),
        ),
      ),
    );
  }
}