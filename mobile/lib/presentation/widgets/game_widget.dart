import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/game.dart';
import 'package:rpg_game/logic/cubits/map_level_cubit.dart';
import 'package:rpg_game/logic/cubits/states/map_level_state.dart';
import 'package:rpg_game/presentation/widgets/buildings/blacksmith_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/castle_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/portal_overlay.dart';
import 'package:rpg_game/presentation/widgets/buildings/shop_overlay.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key key}) : super(key: key);

  @override
  State<MyGameWidget> createState() {
    return _MyGameWidgetState();
  }
}

class _MyGameWidgetState extends State<MyGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(0.0),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/maps/main-map.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              final jsonMap = snapshot.data;

              return BlocBuilder<MapLevelCubit, MapLevelState>(
                builder: (context, state) {
                  return GameWidget<MyGame>(
                    game: MyGame(jsonMap: jsonMap, mapLevel: state.mapLevel),
                    overlayBuilderMap: {
                      'PortalMenu': portalOverlayBuilder,
                      'CastleMenu': castleOverlayBuilder,
                      'BlacksmithMenu': blacksmithOverlayBuilder,
                      'ShopMenu': shopOverlayBuilder,
                    },
                  );
                },
              );
            },
          ),
        ),
    );
  }
}
