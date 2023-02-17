part of 'new_game_bloc.dart';

@immutable
abstract class NewGameState {}

class GamePropsState extends NewGameState {
  final int maxPlayers;
  final int minPerSide;
  final int incPerMove;
  final Side playerSide;

  GamePropsState({
    this.maxPlayers = 0,
    this.minPerSide = 1,
    this.incPerMove = 0,
    this.playerSide = Side.random,
  });

  GamePropsState copyWith({
    int? maxPlayers,
    int? minPerSide,
    int? incPerMove,
    Side? playerSide,
  }) =>
      GamePropsState(
        minPerSide: minPerSide ?? this.minPerSide,
        incPerMove: incPerMove ?? this.incPerMove,
        playerSide: playerSide ?? this.playerSide,
      );
}

class IsCreatingGameState extends NewGameState {}

class SuccessCreateGameState extends NewGameState {}

class FailedCreateGameState extends NewGameState {}
