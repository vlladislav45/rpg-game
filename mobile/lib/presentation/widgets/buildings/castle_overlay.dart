import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubits/map_levels/map_level_cubit.dart';

Widget castleOverlayBuilder(BuildContext context, MyGame myGame) {
  return CastleOverlay(myGame: myGame,);
}

class CastleOverlay extends StatefulWidget {
  final MyGame myGame;

  CastleOverlay({Key? key, required this.myGame}) : super(key: key);

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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('The player was teleported to the dungeon level: 1');

                context.read<MapLevelCubit>().changeMapLevel(1);
              },
              child: Container(
                child: AutoSizeText(
                  'Teleport Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                widget.myGame.overlays.remove('CastleMenu');
              },
              child: Container(
                child: AutoSizeText(
                  'Close',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
