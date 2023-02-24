part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerState {}

class InitialGameControllerState extends GameControllerState {}

class JoiningGameControllerState extends GameControllerState {}

class SuccessJoiningGameControllerState extends GameControllerState {}

class FailureJoiningGameControllerState extends GameControllerState {}

class ReadyGameControllerState extends GameControllerState {
  final GameId gameId;
  final GameState gameState;

  ReadyGameControllerState({required this.gameId, required this.gameState});

  GameControllerState copyWith({GameId? gameId, GameState? gameState}) =>
      ReadyGameControllerState(
          gameId: gameId ?? this.gameId,
          gameState: gameState ?? this.gameState);
}

class WaitingForPlayersState extends GameControllerState {}

class ValidatingMoveState extends GameControllerState {
  final ShortMove move;

  ValidatingMoveState(this.move);
}
