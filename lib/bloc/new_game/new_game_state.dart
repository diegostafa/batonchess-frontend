part of 'new_game_bloc.dart';

class NewGameState {
  final int maxPlayers;
  final int minPerSide;
  final int incrementPerMove;
  final Side side;

  NewGameState(
      {this.maxPlayers = 0,
      this.minPerSide = 0,
      this.incrementPerMove = 0,
      this.side = Side.random});

  NewGameState copyWith(
          {int? maxPlayers, int? minPerSide, int? secPerMove, Side? side}) =>
      NewGameState(
        minPerSide: minPerSide ?? this.minPerSide,
        incrementPerMove: secPerMove ?? this.incrementPerMove,
        side: side ?? this.side,
      );
}
