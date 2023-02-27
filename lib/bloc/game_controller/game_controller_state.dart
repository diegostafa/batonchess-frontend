part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerState {}

class InitialGameControllerState extends GameControllerState {}

class JoiningGameState extends GameControllerState {}

class SuccessJoiningState extends GameControllerState {}

class FailureJoiningState extends GameControllerState {}

class GameReadyState extends GameControllerState {
  final GameId gameId;
  final GameState gameState;

  GameReadyState({required this.gameId, required this.gameState});

  GameReadyState copyWith({GameId? gameId, GameState? gameState}) =>
      GameReadyState(
        gameId: gameId ?? this.gameId,
        gameState: gameState ?? this.gameState,
      );
}

class CheckmateState extends GameControllerState {}
