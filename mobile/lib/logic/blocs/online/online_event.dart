import 'package:flutter/material.dart';

abstract class OnlineEvent {
  const OnlineEvent();

  List<Object> get props => [];
}

class OnlineConnectEvent extends OnlineEvent {

  @override
  List<Object> get props => [];
}

class OnlineConnectingEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineConnectedEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineConnectErrorEvent extends OnlineEvent {
  final Object error;

  OnlineConnectErrorEvent(this.error);

  @override
  List<Object> get props => [error];
}

class OnlineConnectTimeoutEvent extends OnlineEvent {
  final Object error;

  OnlineConnectTimeoutEvent(this.error);

  @override
  List<Object> get props => [error];
}

class OnlineDisconnectEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineErrorEvent extends OnlineEvent {
  final Object error;

  OnlineErrorEvent(this.error);

  @override
  List<Object> get props => [error];
}

class OnlineAuthenticationEvent extends OnlineEvent {
  final String username;
  final String password;

  OnlineAuthenticationEvent({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class OnlineAuthenticatedEvent extends OnlineEvent {
  final String username;

  OnlineAuthenticatedEvent({
    @required this.username,
  });

  factory OnlineAuthenticatedEvent.fromJson(Map<String, dynamic> json) {
    return OnlineAuthenticatedEvent(
      username: json['username'],
    );
  }

  @override
  List<Object> get props => [username];
}