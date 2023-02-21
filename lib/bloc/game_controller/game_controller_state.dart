part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerState {}

class InitialGameControllerState extends GameControllerState {}

class JoiningGameControllerState extends GameControllerState {}

class SuccessJoiningGameControllerState extends GameControllerState {}

class FailureJoiningGameControllerState extends GameControllerState {}

class ReadyGameControllerState extends GameControllerState {
  final GameState gameState;
  final GameInfo gameInfo;

  ReadyGameControllerState({required this.gameState, required this.gameInfo});
}

class ValidatingMoveState extends GameControllerState {
  final ShortMove move;

  ValidatingMoveState(this.move);
}
