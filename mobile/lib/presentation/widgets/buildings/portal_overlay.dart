import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubits/map/map_cubit.dart';

Widget portalOverlayBuilder(BuildContext context, MyGame myGame) {
  return const PortalOverlay();
}

class PortalOverlay extends StatefulWidget {
  const PortalOverlay({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('The player was teleported to the arena');

                context.read<MapCubit>().update(0, 1, isArena: true);
              },
              child: Container(
                child: AutoSizeText(
                  'Arena',
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
