import 'package:rpg_game/model/character_model.dart';
import 'package:rpg_game/model/user_model.dart';

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
  final UserModel userViewModel;

  OnlineAuthenticatedState({
    required this.userViewModel,
  });

  @override
  List<Object> get props => [userViewModel];
}
