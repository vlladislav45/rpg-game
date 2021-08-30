
import 'package:rpg_game/model/character_model.dart';
import 'package:rpg_game/model/user_model.dart';

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

class MultiplayerEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class OnlineAuthenticatedMultiplayerEvent extends GameEvent {
  final List<CharacterModel> players;

  OnlineAuthenticatedMultiplayerEvent({
    required this.players,
  });

  factory OnlineAuthenticatedMultiplayerEvent.fromJson(List<dynamic> json) {
    return OnlineAuthenticatedMultiplayerEvent(
      players: CharacterModel.fromJson(json)
    );
  }

  @override
  List<Object> get props => [players];
}

class UpdateCharacterEvent extends GameEvent {
  final CharacterModel characterModel;

  UpdateCharacterEvent({
    required this.characterModel,
  });

  @override
  List<Object> get props => [characterModel];
}
