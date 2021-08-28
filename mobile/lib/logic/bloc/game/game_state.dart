
import 'package:rpg_game/model/character_model.dart';
import 'package:rpg_game/model/user_model.dart';

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

class OnlineAuthenticatedMultiplayerState extends GameState {
  final List<CharacterModel> players;

  OnlineAuthenticatedMultiplayerState({
    required this.players,
  });

  @override
  List<Object> get props => [players];
}
