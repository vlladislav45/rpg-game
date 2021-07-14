
import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_event.dart';
import 'package:rpg_game/logic/blocs/game/game_state.dart';
import 'package:rpg_game/network/socket_manager.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  GameBloc() : super(GameInitialState()) {
    SocketManager.socket.on('loggedPlayer', (data) => add(GamePropertiesEvent.fromJson(data)));
  }

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if(event is GamePropertiesEvent) {
      yield GamePropertiesState(userModel: event.userModel);
    }else if(event is LoggedEvent) {
      SocketManager.socket.emit('handshake');
    }
  }
}
