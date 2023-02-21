part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerEvent {}

class JoinGameEvent extends GameControllerEvent {
  final JoinGameRequest joinProps;

  JoinGameEvent({required this.joinProps});
}

class LeaveGameEvent extends GameControllerEvent {}

class SubmitMoveEvent extends GameControllerEvent {
  final ShortMove move;

  SubmitMoveEvent({required this.move});
}
