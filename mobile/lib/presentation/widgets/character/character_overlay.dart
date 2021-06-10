
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/utils/hex_color.dart';

Widget characterOverlayBuilder(BuildContext context, MyGame myGame) {
  return CharacterOverlay();
}

class CharacterOverlay extends StatefulWidget {
  @override
  CharacterOverlayState createState() {
    return CharacterOverlayState();
  }
}

class CharacterOverlayState extends State<CharacterOverlay> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Color(HexColor.convertHexColor('#808080')),
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 10,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                AutoSizeText(
                    '1lv'
                ),

                AutoSizeText(
                    'My Name'
                ),
              ],
            )
          ),
          FAProgressBar(
            currentValue: 80,
            displayText: '%',
          ),
          LinearProgressIndicator(
            value: controller.value,
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }
}