part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerState {}

class InitialGameControllerState extends GameControllerState {}

class IdleGameControllerState extends GameControllerState {
  final GameState gameState;
  final int gameId;

  IdleGameControllerState({required this.gameState, required this.gameId});
}

class ValidatingMoveState extends GameControllerState {
  final ShortMove move;

  ValidatingMoveState(this.move);
}
