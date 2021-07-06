
import 'package:rpg_game/models/user_model.dart';

abstract class GameState {
  const GameState();

  List<Object> get props => [];
}

class GameInitialState extends GameState {}

class GameLoggedState extends GameState {}

class GamePropertiesState extends GameState {
  final UserModel userModel;

  GamePropertiesState({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}
