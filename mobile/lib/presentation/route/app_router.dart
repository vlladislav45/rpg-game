import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/bloc/game/game_bloc.dart';
import 'package:rpg_game/logic/bloc/online/online_bloc.dart';
import 'package:rpg_game/logic/cubit/map/map_cubit.dart';
import 'package:rpg_game/presentation/screen/game_screen.dart';
import 'package:rpg_game/presentation/screen/login_screen.dart';

class AppRouter {
  // Cubit
  MapCubit _mapCubit = MapCubit();

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
          ], child: MyGameScreen(),
          ),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _mapCubit.close();
    _onlineBloc.close();
    _gameBloc.close();
  }
}
