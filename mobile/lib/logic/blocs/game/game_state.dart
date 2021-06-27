
import 'package:rpg_game/models/user_model.dart';

abstract class GameState {
  const GameState();

  List<Object> get props => [];
}

class GamePropertiesState extends GameState {
  final UserModel userModel;

  GamePropertiesState({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}