import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';

Widget portalOverlayBuilder(BuildContext context, MyGame myGame) {
  return const PortalOverlay();
}

class PortalOverlay extends StatefulWidget {

  const PortalOverlay({Key? key}): super(key: key);

  @override
  _PortalOverlayState createState() => _PortalOverlayState();
}

class _PortalOverlayState extends State<PortalOverlay> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        color: const Color(0xFFFF0000),
        child: const Center(
          child: Text('Portal Menu'),
        ),
      ),
    );
  }
}