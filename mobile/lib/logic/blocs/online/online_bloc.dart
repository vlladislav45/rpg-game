import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_event.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';
import 'package:rpg_game/network/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';

class OnlineBloc extends Bloc<OnlineEvent, OnlineState> {
  static const String url = 'localhost';
  static const String port = '9092';

  OnlineBloc()
      : super(OnlineInitialState()) {
    SocketManager.configure(url, port);

    SocketManager.socket.onConnecting((data) => add(OnlineConnectingEvent()));
    SocketManager.socket.onConnect((data) => add(OnlineConnectedEvent()));
    SocketManager.socket.onConnectError((data) => add(OnlineConnectErrorEvent(data)));
    SocketManager.socket.onConnectTimeout((data) => add(OnlineConnectTimeoutEvent(data)));
    SocketManager.socket.onDisconnect((data) => add(OnlineDisconnectEvent()));
    SocketManager.socket.onError((data) => add(OnlineErrorEvent(data)));
    SocketManager.socket.on('authenticated', (data) => add(OnlineAuthenticatedEvent.fromJson(data)));
    SocketManager.socket.on('authenticationError', (data) => add(OnlineAuthenticationErrorEvent.fromJson(data)));
  }

  @override
  Stream<OnlineState> mapEventToState(OnlineEvent event) async* {
    if (event is OnlineConnectEvent) {
      yield OnlineConnectingState();
      SocketManager.socket.connect();
    }else if (event is OnlineAuthenticationEvent) {
      SocketManager.socket.emit('authentication', {
        'username': event.username,
        'password': event.password
      });
    }else if (event is OnlineAuthenticatedEvent) {
      yield OnlineAuthenticatedState(
          userViewModel: event.userViewModel,
      );
    }else if(event is OnlineAuthenticationErrorEvent) {
      yield OnlineErrorState(
        event.error,
      );
    } else if (event is OnlineConnectingEvent) {
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
    SocketManager.socket.dispose();
    return super.close();
  }
}