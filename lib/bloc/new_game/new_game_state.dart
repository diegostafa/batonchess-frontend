part of 'new_game_bloc.dart';

class NewGameState {
  final int maxPlayers;
  final int minPerSide;
  final int secondsPerMove;
  final Side side;

  NewGameState({
    this.maxPlayers = 0,
    this.minPerSide = 1,
    this.secondsPerMove = 0,
    this.side = Side.random,
  });

  NewGameState copyWith({
    int? maxPlayers,
    int? minPerSide,
    int? secondsPerMove,
    Side? side,
  }) =>
      NewGameState(
        minPerSide: minPerSide ?? this.minPerSide,
        secondsPerMove: secondsPerMove ?? this.secondsPerMove,
        side: side ?? this.side,
      );
}
