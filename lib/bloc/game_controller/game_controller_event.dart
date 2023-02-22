part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerEvent {}

class JoinGameEvent extends GameControllerEvent {
  final JoinGameRequest joinReq;

  JoinGameEvent({required this.joinReq});
}

class LeaveGameEvent extends GameControllerEvent {}

class SubmitMoveEvent extends GameControllerEvent {
  final ShortMove move;

  SubmitMoveEvent({required this.move});
}
