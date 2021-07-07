import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubits/map/map_cubit.dart';
import 'package:rpg_game/utils/hex_color.dart';

Widget portalOverlayBuilder(BuildContext context, MyGame myGame) {
  return PortalOverlay(myGame: myGame);
}

class PortalOverlay extends StatefulWidget {
  final MyGame myGame;

  const PortalOverlay({Key? key, required this.myGame}) : super(key: key);

  @override
  _PortalOverlayState createState() => _PortalOverlayState();
}

class _PortalOverlayState extends State<PortalOverlay> {
  final String _portalOverlay = 'PortalMenu';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(HexColor.convertHexColor('#3A1E15')),
                Color(HexColor.convertHexColor('#EDE7AB')),
              ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('The player was teleported to the arena');

                context.read<MapCubit>().update(0, 1, isArena: true);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Single player',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.0,),

            ElevatedButton(
              onPressed: () {
                widget.myGame.overlays.remove(_portalOverlay);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
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
