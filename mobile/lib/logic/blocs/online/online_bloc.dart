import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_event.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class OnlineBloc extends Bloc<OnlineEvent, OnlineState> {
  late Socket _socket;

  OnlineBloc([String address = 'ws://localhost:9092'])
      : super(OnlineInitialState()) {
    _socket = io(
      address,
      OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );
    _socket.onConnecting((data) => add(OnlineConnectingEvent()));
    _socket.onConnect((data) => add(OnlineConnectedEvent()));
    _socket.onConnectError((data) => add(OnlineConnectErrorEvent(data)));
    _socket.onConnectTimeout((data) => add(OnlineConnectTimeoutEvent(data)));
    _socket.onDisconnect((data) => add(OnlineDisconnectEvent()));
    _socket.onError((data) => add(OnlineErrorEvent(data)));
    _socket.on('authenticated', (data) => add(OnlineAuthenticatedEvent.fromJson(data)));
  }

  @override
  Stream<OnlineState> mapEventToState(OnlineEvent event) async* {
    if (event is OnlineConnectEvent) {
      yield OnlineConnectingState();
      _socket.connect();
    }else if (event is OnlineAuthenticationEvent) {
      _socket.emit('authentication', {
        'username': event.username,
        'password': event.password
      });
    }else if (event is OnlineAuthenticatedEvent) {
      yield OnlineAuthenticatedState(
          id: event.id,
          email: event.email,
          username: event.username,
      );
    }
    else if (event is OnlineConnectingEvent) {
      yield OnlineConnectingState();
    } else if (event is OnlineConnectedEvent) {
      yield OnlineConnectedState();
    } else if (event is OnlineConnectErrorEvent) {
      yield OnlineConnectErrorState(event.error);
    } else if (event is OnlineConnectTimeoutEvent) {
      yield OnlineConnectTimeoutState(event.error);
    } else if (event is OnlineDisconnectEvent) {
      yield OnlineDisconnectedState();
    } else if (event is OnlineErrorEvent) {
      yield OnlineErrorState(event.error);
    }
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}