import 'package:rpg_game/models/character_model.dart';
import 'package:rpg_game/models/user_model.dart';

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
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class OnlineAuthenticatedEvent extends OnlineEvent {
  final UserModel userViewModel;

  OnlineAuthenticatedEvent({
    required this.userViewModel,
  });

  factory OnlineAuthenticatedEvent.fromJson(Map<String, dynamic> json) {
    return OnlineAuthenticatedEvent(
      userViewModel: UserModel.fromJson(json),
    );
  }

  @override
  List<Object> get props => [userViewModel];
}

class OnlineAuthenticationErrorEvent extends OnlineEvent {
  final String error;

  OnlineAuthenticationErrorEvent({
    required this.error,
  });

  factory OnlineAuthenticationErrorEvent.fromJson(Map<String, dynamic> json) {
    return OnlineAuthenticationErrorEvent(
      error: json['error'],
    );
  }

  @override
  List<Object> get props => [error];
}