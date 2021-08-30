
import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/bloc/game/game_event.dart';
import 'package:rpg_game/logic/bloc/game/game_state.dart';
import 'package:rpg_game/network/socket_manager.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  GameBloc() : super(GameInitialState()) {
    SocketManager.socket.on('loggedPlayer', (data) => add(GamePropertiesEvent.fromJson(data)));
    SocketManager.socket.on('firstUpdate', (data) => add(OnlineAuthenticatedMultiplayerEvent.fromJson(data)));
  }

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if(event is GamePropertiesEvent) {
      yield GamePropertiesState(userModel: event.userModel);
    }else if(event is LoggedEvent) {
      SocketManager.socket.emit('handshake');
    }else if(event is MultiplayerEvent) {
      SocketManager.socket.emit('multiplayer');
    } else if(event is SingleplayerEvent) {
     yield SingleplayerState();
    }
    else if(event is OnlineAuthenticatedMultiplayerEvent) {
      yield OnlineAuthenticatedMultiplayerState(
        players: event.players,
      );
    }else if(event is UpdateCharacterEvent) {
      SocketManager.socket.emit("update", event.characterModel);
    }
  }
}
