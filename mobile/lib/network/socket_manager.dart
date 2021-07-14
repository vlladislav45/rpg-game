
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  static late final Socket socket;
  static late final SocketManager _socketManager = SocketManager._internal();

  factory SocketManager() {
    return _socketManager;
  }
  SocketManager._internal();

  static configure(String url, String port) {
    socket = io(
        'ws://$url:$port',
        OptionBuilder()
            .setTransports(['websocket'])
            .setTimeout(3000)
            .disableAutoConnect()
            .disableReconnection()
            .build()
    );
  }

  bool get connected => socket.connected;
}