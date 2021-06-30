import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/blocs/game/game_bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_event.dart';
import 'package:rpg_game/logic/blocs/game/game_state.dart';
import 'package:rpg_game/logic/cubits/map/map_cubit.dart';
import 'package:rpg_game/logic/cubits/map/map_state.dart';
import 'package:rpg_game/presentation/widgets/buildings/blacksmith_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/castle_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/portal_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/shop_overlay.dart';
import 'package:rpg_game/presentation/widgets/character/character_overlay.dart';

class MyGameScreen extends StatefulWidget {
  const MyGameScreen({Key? key}) : super(key: key);

  @override
  State<MyGameScreen> createState() {
    return _MyGameScreenState();
  }
}

class _MyGameScreenState extends State<MyGameScreen> {
  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();

    // init blocs
    _gameBloc = context.read<GameBloc>();
  }

  @override
  Widget build(BuildContext context) {
    _gameBloc.add(LoggedEvent());

    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(0.0),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/maps/level1.json'),
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
                  return BlocBuilder<GameBloc, GameState>(
                  builder: (context, gameState) {
                  if (gameState is GamePropertiesState) {
                    return GameWidget<MyGame>(
                      game: MyGame(jsonMap: jsonMap.toString(),
                          context: context,
                          mapLevel: state.map,
                          arena: state.arena,
                          characterModel: gameState.userModel.characters[0],
                          viewportResolution: Vector2(MediaQuery.of(context).size.width,
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
            },
          ),
        ),
    );
  }
}
