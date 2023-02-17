part of 'new_game_bloc.dart';

@immutable
abstract class NewGameState {}

class GamePropsState extends NewGameState {
  final int maxPlayers;
  // final int minPerSide;
  // final int incPerMove;
  final bool playAsWhite;

  GamePropsState({
    this.maxPlayers = 0,
    // this.minPerSide = 1,
    // this.incPerMove = 0,
    this.playAsWhite = true,
  });

  GamePropsState copyWith({
    int? maxPlayers,
    // int? minPerSide,
    // int? incPerMove,
    bool? playAsWhite,
  }) =>
      GamePropsState(
        // minPerSide: minPerSide ?? this.minPerSide,
        // incPerMove: incPerMove ?? this.incPerMove,
        playAsWhite: playAsWhite ?? this.playAsWhite,
      );
}

class IsCreatingGameState extends NewGameState {}

class SuccessCreateGameState extends NewGameState {}

class FailedCreateGameState extends NewGameState {}
