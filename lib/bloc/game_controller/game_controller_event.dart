part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerEvent {}

class JoinGameEvent extends GameControllerEvent {
  final JoinGameRequest joinReq;

  JoinGameEvent({required this.joinReq});
}

class LeaveGameEvent extends GameControllerEvent {}

class NewGameStateEvent extends GameControllerEvent {
  final GameId gameId;
  final GameState gameState;

  NewGameStateEvent({required this.gameId, required this.gameState});
}

class FailedToJoinGameEvent extends GameControllerEvent {}

class FailedToUpdateFenEvent extends GameControllerEvent {}

class SubmitMoveEvent extends GameControllerEvent {
  final ShortMove move;

  SubmitMoveEvent({required this.move});
}
