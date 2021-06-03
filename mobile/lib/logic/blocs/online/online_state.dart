import 'package:flutter/material.dart';

abstract class OnlineState {
  const OnlineState();

  List<Object> get props => [];
}

class OnlineInitialState extends OnlineState {
  @override
  List<Object> get props => [];
}

class OnlineConnectingState extends OnlineState {
  @override
  List<Object> get props => [];
}

class OnlineConnectErrorState extends OnlineState {
final Object error;

OnlineConnectErrorState(this.error);

@override
List<Object> get props => [error];
}

class OnlineConnectTimeoutState extends OnlineState {
  final Object error;

  OnlineConnectTimeoutState(this.error);

  @override
  List<Object> get props => [error];
}

class OnlineConnectedState extends OnlineState {
  @override
  List<Object> get props => [];
}

class OnlineDisconnectedState extends OnlineState {
  @override
  List<Object> get props => [];
}

class OnlineErrorState extends OnlineState {
  final Object error;

  OnlineErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class OnlineAuthenticationState extends OnlineState {
  @override
  List<Object> get props => [];
}

class OnlineAuthenticatedState extends OnlineState {
  final String id;
  final String username;
  final String email;

  OnlineAuthenticatedState({
    @required this.id,
    @required this.username,
    @required this.email,
  });

  @override
  List<Object> get props => [id, email, username];
}