
import 'package:rpg_game/models/user_model.dart';

abstract class GameState {
  const GameState();

  List<Object> get props => [];
}

class GamePlayerState extends GameState {
  final UserModel userModel;

  GamePlayerState({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}