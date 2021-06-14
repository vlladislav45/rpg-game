import 'package:rpg_game/models/views/character_view_model.dart';
import 'package:rpg_game/models/views/user_view_model.dart';

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
  final UserViewModel userViewModel;

  OnlineAuthenticatedEvent({
    required this.userViewModel,
  });

  factory OnlineAuthenticatedEvent.fromJson(Map<String, dynamic> json) {
    return OnlineAuthenticatedEvent(
      userViewModel: UserViewModel.fromJson(json),
    );
  }

  @override
  List<Object> get props => [userViewModel];
}