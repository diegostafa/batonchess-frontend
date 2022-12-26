part of 'new_game_bloc.dart';

@immutable
abstract class NewGameState {}

class GamePropsState extends NewGameState {
  final int maxPlayers;
  final int minPerSide;
  final int secondsPerMove;
  final Side side;

  GamePropsState({
    this.maxPlayers = 0,
    this.minPerSide = 1,
    this.secondsPerMove = 0,
    this.side = Side.random,
  });

  GamePropsState copyWith(
          {int? maxPlayers,
          int? minPerSide,
          int? secondsPerMove,
          Side? side,}) =>
      GamePropsState(
          minPerSide: minPerSide ?? this.minPerSide,
          secondsPerMove: secondsPerMove ?? this.secondsPerMove,
          side: side ?? this.side,);
}

class IsCreatingGameState extends NewGameState {}

class SuccessCreateGameState extends NewGameState {}

class FailedCreateGameState extends NewGameState {}
