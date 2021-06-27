
import 'package:rpg_game/models/user_model.dart';

abstract class GameEvent {
  const GameEvent();

  List<Object> get props => [];
}

class LoggedEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class GamePropertiesEvent extends GameEvent {
  final UserModel userModel;

  GamePropertiesEvent({
    required this.userModel,
  });

  factory GamePropertiesEvent.fromJson(Map<String, dynamic> json) {
    return GamePropertiesEvent(
      userModel: UserModel.fromJson(json),
    );
  }

  @override
  List<Object> get props => [userModel];
}