import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/cubits/character_overlay/character_overlay_cubit.dart';
import 'package:rpg_game/logic/cubits/map/map_cubit.dart';
import 'package:rpg_game/presentation/screens/game_screen.dart';
import 'package:rpg_game/presentation/screens/login_screen.dart';

class AppRouter {
  // Cubit
  MapCubit _mapCubit = MapCubit();
  CharacterOverlayCubit _characterOverlayCubit = CharacterOverlayCubit();

  // Bloc
  OnlineBloc _onlineBloc = OnlineBloc();
  GameBloc _gameBloc = GameBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/'),
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _mapCubit,
                  ),
                  BlocProvider.value(
                    value: _onlineBloc,
                  ),
                ], child: LoginScreen()
            ),
        );
      case '/game':
        return MaterialPageRoute(
          settings: RouteSettings(name: '/game'),
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _mapCubit,
            ),
            BlocProvider.value(
              value: _onlineBloc,
            ),
            BlocProvider.value(
              value: _gameBloc,
            ),
            BlocProvider.value(
              value: _characterOverlayCubit,
            ),
          ], child: MyGameScreen(),
          ),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _characterOverlayCubit.close();
    _mapCubit.close();
    _onlineBloc.close();
    _gameBloc.close();
  }
}
