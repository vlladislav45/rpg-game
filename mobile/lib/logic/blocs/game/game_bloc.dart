
import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/blocs/game/game_event.dart';
import 'package:rpg_game/logic/blocs/game/game_state.dart';
import 'package:rpg_game/network/socket_manager.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  GameBloc() : super(null) {
    SocketManager.socket.on('authenticated', (data) => add(GamePlayerEvent.fromJson(data)));
  }

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if(event is GamePlayerEvent) {
      yield GamePlayerState(userModel: event.userModel);
    }
  }
}