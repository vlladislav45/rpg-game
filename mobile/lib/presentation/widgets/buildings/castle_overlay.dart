
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubits/map_level_cubit.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            color: Colors.white,
            child: const Center(
              child: Text('Castle Menu'),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              print('BUtton is tapped');

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
          )
        ],
      ),
    );
  }
}