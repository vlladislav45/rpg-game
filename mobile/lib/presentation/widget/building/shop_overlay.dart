import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/util/hex_color.dart';

Widget shopOverlayBuilder(BuildContext context, MyGame myGame) {
  return ShopOverlay(myGame: myGame);
}

class ShopOverlay extends StatefulWidget {
  final MyGame myGame;

  const ShopOverlay({Key? key, required this.myGame}) : super(key: key);

  @override
  _ShopOverlayState createState() => _ShopOverlayState();
}

class _ShopOverlayState extends State<ShopOverlay> {
  final String _shopOverlay = 'ShopMenu';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
          height: MediaQuery
              .of(context)
              .size
              .height / 2,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            gradient:
            LinearGradient(begin: Alignment.topLeft, end: Alignment(0.8, 0.0),
                // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(HexColor.convertHexColor('#3A1E15')),
                  Color(HexColor.convertHexColor('#EDE7AB')),
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  widget.myGame.overlays.remove(_shopOverlay);
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 5,
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
