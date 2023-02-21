part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerState {}

class IdleGameControllerState extends GameControllerState {
  final GameState gameState;

  IdleGameControllerState({required this.gameState});
}

class ValidatingMoveState extends GameControllerState {
  final ShortMove move;

  ValidatingMoveState(this.move);
}
