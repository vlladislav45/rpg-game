import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/bloc/online/online_bloc.dart';
import 'package:rpg_game/logic/bloc/online/online_state.dart';
import 'package:rpg_game/logic/cubit/map/map_cubit.dart';
import 'package:rpg_game/logic/cubit/map/map_state.dart';
import 'package:rpg_game/presentation/widget/building/blacksmith_overlay.dart';
import 'package:rpg_game/presentation/widget/building/castle_overlay.dart';
import 'package:rpg_game/presentation/widget/building/portal_overlay.dart';
import 'package:rpg_game/presentation/widget/building/shop_overlay.dart';
import 'package:rpg_game/presentation/widget/character/character_overlay.dart';

class MyGameScreen extends StatefulWidget {
  const MyGameScreen({Key? key}) : super(key: key);

  @override
  State<MyGameScreen> createState() {
    return _MyGameScreenState();
  }
}

class _MyGameScreenState extends State<MyGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.all(0.0),
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, mapState) {
            if(mapState.map == '') {
              return BlocBuilder<MapCubit, MapState>(
                      builder: (context, state) {
                        return BlocBuilder<OnlineBloc, OnlineState>(
                            builder: (context, gameState) {
                              if (gameState is OnlineAuthenticatedState) {
                                return GameWidget<MyGame>(
                                  game: MyGame(
                                      jsonMap: '',
                                      context: context,
                                      loadMapLevel: false,
                                      characterModel: gameState.userViewModel.characters[0],
                                      viewportResolution: Vector2(
                                          MediaQuery.of(context).size.width,
                                          MediaQuery.of(context).size.height)),
                                  overlayBuilderMap: {
                                    'PortalMenu': portalOverlayBuilder,
                                    'CastleMenu': castleOverlayBuilder,
                                    'BlacksmithMenu': blacksmithOverlayBuilder,
                                    'ShopMenu': shopOverlayBuilder,
                                    'CharacterOverlay': characterOverlayBuilder,
                                  },
                                );
                              }
                              return CircularProgressIndicator();
                            });
                      });
            }
            print(mapState.map);
            return FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/maps/${mapState.map}.json'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting)
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  final jsonMap = snapshot.data;

                  return BlocBuilder<MapCubit, MapState>(
                    builder: (context, state) {
                      return BlocBuilder<OnlineBloc, OnlineState>(
                          builder: (context, gameState) {
                            if (gameState is OnlineAuthenticatedState) {
                              return GameWidget<MyGame>(
                                game: MyGame(
                                    jsonMap: jsonMap.toString(),
                                    context: context,
                                    loadMapLevel: true,
                                    characterModel: gameState.userViewModel.characters[0],
                                    viewportResolution: Vector2(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height)),
                                overlayBuilderMap: {
                                  'PortalMenu': portalOverlayBuilder,
                                  'CastleMenu': castleOverlayBuilder,
                                  'BlacksmithMenu': blacksmithOverlayBuilder,
                                  'ShopMenu': shopOverlayBuilder,
                                  'CharacterOverlay': characterOverlayBuilder,
                                },
                              );
                            }
                            return CircularProgressIndicator();
                          });
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
