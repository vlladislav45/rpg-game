import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/cubits/map_level_cubit.dart';
import 'package:rpg_game/presentation/widgets/game_widget.dart';
import 'package:rpg_game/presentation/widgets/buildings/castle_overlay.dart';

class AppRouter {
  MapLevelCubit _mapLevelCubit = MapLevelCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/'),
          builder: (_) => BlocProvider.value(
            value: _mapLevelCubit,
            child: MyGameWidget(),
          ),
        );
      case '/castle':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/castle'),
          builder: (_) => BlocProvider.value(
            value: _mapLevelCubit,
            child: CastleOverlay(),
          ),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _mapLevelCubit.close();
  }
}
