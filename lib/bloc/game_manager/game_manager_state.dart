part of "game_manager_bloc.dart";

@immutable
abstract class GameManagerState {}

class IdleGameManagerState extends GameManagerState {
  final GameState gameState;

  IdleGameManagerState({required this.gameState});
}

class ValidatingMoveState extends GameManagerState {
  final ShortMove move;

  ValidatingMoveState(this.move);
}
