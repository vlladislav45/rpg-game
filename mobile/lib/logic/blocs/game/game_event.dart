
import 'package:rpg_game/models/user_model.dart';

abstract class GameEvent {
  const GameEvent();

  List<Object> get props => [];
}

class GamePlayerEvent extends GameEvent {
  final UserModel userModel;

  GamePlayerEvent({
    required this.userModel,
  });

  factory GamePlayerEvent.fromJson(Map<String, dynamic> json) {
    return GamePlayerEvent(
      userModel: UserModel.fromJson(json),
    );
  }

  @override
  List<Object> get props => [userModel];
}