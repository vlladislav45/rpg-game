import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/cubits/map_levels/map_level_cubit.dart';
import 'package:rpg_game/presentation/screens/character_select_screen.dart';
import 'package:rpg_game/presentation/screens/game_screen.dart';
import 'package:rpg_game/presentation/screens/login_screen.dart';

class AppRouter {
  MapLevelCubit _mapLevelCubit = MapLevelCubit();
  OnlineBloc _onlineBloc = OnlineBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/'),
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _mapLevelCubit,
                  ),
                  BlocProvider.value(
                    value: _onlineBloc,
                  ),
                ], child: LoginScreen()
            ),
        );
      case '/character-select':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/character-select'),
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _mapLevelCubit,
            ),
            BlocProvider.value(
              value: _onlineBloc,
            ),
          ], child: CharacterSelectScreen()
          ),
        );
      case '/game':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/game'),
          builder: (_) => BlocProvider.value(
            value: _mapLevelCubit,
            child: MyGameScreen(),
          ),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _mapLevelCubit.close();
    _onlineBloc.close();
  }
}
